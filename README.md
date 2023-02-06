<h1>Repositório dos arquivos para o projeto Tech Day do Bootcamp "Cloud DevOps Experience - Banco Carrefour".</h1>

<h3>Objetivo</h3>

Criar imagem de uma aplicação fornecida previamente, subir a aplicação e deixar rodando em um cluster kubernetes no google cloud através de CI/CD.

<h2>Características da aplicação:</h2>

- Frontend (HTML/CSS/JS), usado na máquina do cliente para acesso ao Backend.<br>
• Backend (PHP e MySQL), hospedado no GKE da GoogleCloud.

<h3>Uso da Aplicação</h3>

Para acessar a aplicação é preciso copiar a pastar frontend para a máquina do cliente e configurar o arquivo js.js com ip do loadbalance do cluster e abrir o arquivo index.html.

<h2>Características da Infraestrutura no Google Cloud:</h2>

- VPC<br>
• Subnet<br>
• GKE (Cluster contendo dois pools. Serviços: loadbalance, PV, PVC, Mysql-connection )<br>
• Bucket - Criado anteriormente para receber os arquivos de estado do terraform.

<h3>Características do CI/CD</h3>

A entrega é feita pelo Github actions por dois jobs.

O primeiro job usa o Dockerfile e os dados da pasta backend para buildar a imagem e jogar no Dockerhub.

O segundo job cria toda a infraestrutura as code com terraform.

O terraform também instala o Flux no K8s que usará o repositório [https://github.com/andersonluix/carrefour-techday-cloud-devops-flux](https://github.com/andersonluix/carrefour-techday-cloud-devops-flux) para configurar o cluster.

O terraform state é armazenado no bucket já criado no GCP. O armazenamento do estado da infra é importantoe para o CD funcionar.

As váriaveis de uso pelo secrets do kubernetes são passadas através do secrets do github.

<h3>Detalhes do Flux para configuração do cluster no K8s</h3>

Resumidamente, O Flux é uma coleção de ferramentas para manter os clusters do Kubernetes sincronizados com as fontes de configuração (como repositórios Git) e automatizar as atualizações da configuração quando há um novo código para implantar.<br>

O bootstrap é feito pelo terraform passando os dados necessários para configuração.<br> 
O Flux utiliza o repositório https://github.com/andersonluix/carrefour-techday-cloud-devops-flux com os Yamls de configuração.<br>
Assim como temos um maior e melhor controle do CD para futuras atualizações, correções de código, etc.

<h3>Detalhes do terraform para criação da infraestrutura</h3>

Foi utilizado os providers kubectl e kubernetes para fazer acesso ao cluster e fazer as configurações iniciais no K8s, o Flux e o secrets<br>
Os resources kubectl e kubernetes fazem a autenticação no cluster usando protocolo OAuth2.<br>
Assim como o resource kubernetes_secret, que cria o secret my-secret no kubernets pegando o valor das variáveis no secrets do github, também usa o OAuth2 para autenticação.<br>
Foi usado o terraform backend para guardar o terraform state no bucket.

<h3>Detalhes do kubernetes</h3>

Uso de Cluster com 4 nodes, rodando 6 réplicas da aplicação e um replicated stateful mysql.
Uso do ingress para possível escalabilidade do projeto com outros aplicativos.
Uso de secrets para informações sensíveis de user e senha.
Uso de um ConfigMap para a criação da tabela a ser usada pela aplicação no mysql.
Uso de livenessProbe e readnesProbe para health check em ambos containers.

Uso de HPA, para fazer o autoscaling da aplicação de acordo com o uso de processamento.

Para o mysql o statefulset cria 3 nós, onde um funciona como master e duas réplicas para consulta. Os nós mantém interação e ficam replicando os dados do mysql com a ajuda do xtrabackup.
