<h1>Repositório dos arquivos do projeto base para o projeto Tech Day do Bootcamp "Cloud DevOps Experience - Banco Carre$

<h2>Características da aplicação:</h2>

•       Frontend (HTML/CSS/JS)<br>
•       Backend (PHP e MySQL)

<h2>Características da Infraestrutura no Goocle Clod:</h2>

•       VPC 
•       Subnet
•       Filestore (NFS onde serão armazenados os dados do Mysql)
•       GKE (Cluster contendo dois pools. Serviços: loadbalance, PV, PVC, Mysql-connection )


<h3>Cracteristicas do CI/CD</h3>

A entrega é feita pelo Github actions por dois jobs.

O primeiro job usa o Dockerfile e os dados da pasta backend para buildar a imagem e jogar no Dockerhub.

O segundo job cria toda a infraestrutura as code com terraform, inclusive faz todo o deploy da aplicação 
no cluster kubernetes.

Para acessar a aplicação é preciso copiar a pastar frontend para a máquina do cliente e configurar o 
arquivo js.js com ip do loadbalance do cluster e abrir o arquivo index.html.

<h3>Detalhes do terraform para criação da infraestrutura</h3> 

Foi utilizado o resource kubectl_manifest para fazer acesso ao cluster e fazer o deploy.
O resource kubectl_manifest faz a autenticação no cluster usando protocolo OAuth2.
Assim como o provider kubernetes_secret, que cria o secret my-secret no kubernets pegando o valor
das variáveis no secrets do github.

<h2>Entrega do projeto</h2>

Com o problema apresentado, o participante poderá entrar o seu pipeline de CI/CD utilizando o Gitlab, Terraform ou outr$

https://gitlab.com/denilsonbonatti/app-cicd-dio/-/blob/main/.gitlab-ci.yml

O participante deverá apresentar um vídeo com o pit da sua solução com no máximo 5 minutos.

Link do formulário de entrega:

https://forms.office.com/r/S8MHD0HrUb