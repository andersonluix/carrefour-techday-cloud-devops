#Cria estrutura dentro do K8s
resource "kubectl_manifest" "loadbalance" {
    yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  name: backendlb
spec:
  ports:
    - port: 80
      targetPort: 80
  selector:
    app: app-backend 
  type: LoadBalancer

YAML
 depends_on = [
    kubectl_manifest.deployment_app
 ]
}

resource "kubectl_manifest" "mysql-connection" {
    yaml_body = <<YAML

apiVersion: v1
kind: Service
metadata:
  name: mysql-connection
spec:
  ports:
  - port: 3306
  selector:
    app: mysql
  clusterIP: None

YAML

depends_on = [
    kubectl_manifest.deployment_mysql
 ]

}

resource "kubectl_manifest" "pv" {
    yaml_body = <<YAML
    
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-fileserver-nfs

spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteMany
  nfs:               
    path: /database     #Nome do compartilhamento de arquivos(filestore)
    server: "${google_filestore_instance.instance.networks.0.ip_addresses.0}"   #10.58.162.178 #ip do filestore ou do servidor NFS
YAML

depends_on = [
    #kubectl_manifest.mysql-connection
    google_container_node_pool.pool
 ]

}

resource "kubectl_manifest" "pvc" {
    yaml_body = <<YAML

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-fileserver-nfs
spec:
  storageClassName: "" #A GCP pede que deixe este campo so com aspas em branco
  accessModes:
  accessModes:
    - ReadWriteMany
  volumeName: pv-fileserver-nfs
  resources:
    requests:
      storage: 10Gi
 
 YAML

 depends_on = [
    kubectl_manifest.pv
 ]
}

resource "kubectl_manifest" "deployment_mysql" {
    yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
spec:
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - image: mysql:5.6
        name: mysql
        args:
          - "--ignore-db-dir=lost+found"
        env:
        - name: MYSQL_ROOT_PASSWORD    #nome da variavel da imagem
          valueFrom:
            secretKeyRef:
              name: my-secret          #nome do serviço secret criado
              key: ROOT_PASSWORD       #variavel no secret que contem a chave que queremos
        - name: MYSQL_DATABASE
          valueFrom:
            secretKeyRef:
              name: my-secret          #nome do serviço secret criado
              key: MYSQL_DATABASE      #variavel no secret que contem a chave que queremos

        #sempre baixa a imagem a cada execucao
        #imagePullPolicy: Always           
        ports:
        - containerPort: 3306
          name: mysql

        volumeMounts:
        - name: local
          mountPath: /var/lib/mysql

        - name: mysql-initdb
          mountPath: /docker-entrypoint-initdb.d
      
      volumes:
      - name: mysql-initdb
        configMap:
          name: mysql-initdb-config
        
      - name: local
        persistentVolumeClaim:
          claimName: pvc-fileserver-nfs
 YAML

 depends_on = [
    kubectl_manifest.pvc,
    kubectl_manifest.deployment_configmap
 ]
}

resource "kubectl_manifest" "deployment_configmap" {
    yaml_body = <<YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: mysql-initdb-config
data:
  initdb.sql: |
    USE meubanco;
    CREATE TABLE mensagens (id int, nome VARCHAR(256), email VARCHAR(100), comentario VARCHAR(150));

YAML
 depends_on = [
    kubectl_manifest.loadbalance
 ]
}

resource "kubectl_manifest" "deployment_app" {
    yaml_body = <<YAML

apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-backend
  labels:
    app: app-backend
spec:
  replicas: 6
  selector:
    matchLabels:
      app: app-backend
  template:
    metadata:
      labels:
        app: app-backend
    spec:
      containers:
      - image: andersonlbsilva/app-bc-carrefour-dio:1.0
        name: app-backend
        #sempre baixa a imagem a cada execucao
        imagePullPolicy: Always
        ports:
        - containerPort: 80


YAML

 depends_on = [
    kubectl_manifest.deployment_mysql,
    kubectl_manifest.mysql-connection
 ]

}