<h1>Repositório dos arquivos para o projeto Tech Day do Bootcamp "Cloud DevOps Experience - Banco Carrefour".</h1>

<h2>Características da aplicação:</h2>

•       Frontend (HTML/CSS/JS), usado na máquina do cliente para acesso ao Backend.<br>
•       Backend (PHP e MySQL), hospedado no GKE da GoogleCloud.

<h3>Uso da Aplicação</h3>

Para acessar a aplicação é preciso copiar a pastar frontend para a máquina do cliente e configurar o arquivo js.js com ip do loadbalance do cluster e abrir o arquivo index.html.


<h2>Características da Infraestrutura no Google Cloud:</h2>

•       VPC<br>
•       Subnet<br>
•       Filestore (NFS onde serão armazenados os dados do Mysql)<br>
•       GKE (Cluster contendo dois pools. Serviços: loadbalance, PV, PVC, Mysql-connection )<br>
•       Bucket - Criado anteriormente para receber os arquivos de estado do terraform.


<h3>Características do CI/CD</h3>

A entrega é feita pelo Github actions por dois jobs.

O primeiro job usa o Dockerfile e os dados da pasta backend para buildar a imagem e jogar no Dockerhub.

O segundo job cria toda a infraestrutura as code com terraform, inclusive faz todo o deploy da aplicação no cluster kubernetes.

O terraform state é armazenado no bucket já criado no GCP. O armazenamento do estado da infra é importantoe para o CD funcionar.

As váriaveis de uso pelo secrets do kubernetes são passadas através do secrets do github.

<h3>Detalhes do terraform para criação da infraestrutura</h3> 

Foi utilizado o resource kubectl_manifest para fazer acesso ao cluster e fazer o deploy.<br>
O resource kubectl_manifest faz a autenticação no cluster usando protocolo OAuth2.<br>
Assim como o provider kubernetes_secret, que cria o secret my-secret no kubernets pegando o valor das variáveis no secrets do github, também usa o OAuth2 para autenticação.<br>
Foi usado o terraform backend para guardar o terraform state no bucket.

<h3>Detalhes do kubernetes</h3>

Uso de Cluster com 2 nodes, rodando 6 réplicas da aplicação e um pod do mysql.
Uso do PV para armazenamento dos dados do BD apontando para um Filestore no GCP.
Uso de um service loadbalance.
Uso de secrets para informações sensíveis de user e senha.
Uso de um ConfigMap para a criação da tabela a ser usada pela aplicação no mysql.
Uso de livenessProbe e readnesProbe para health check em ambos containers.


<h2>Entrega do projeto</h2>

Com o problema apresentado, o participante poderá entrar o seu pipeline de CI/CD utilizando o Gitlab, Terraform ou outr$

https://gitlab.com/denilsonbonatti/app-cicd-dio/-/blob/main/.gitlab-ci.yml

O participante deverá apresentar um vídeo com o pit da sua solução com no máximo 5 minutos.

Link do formulário de entrega:

https://forms.office.com/r/S8MHD0HrUb