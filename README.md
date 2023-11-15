# Connect directly to Docker-for-Mac containers via IP address.
- https://github.com/chipmk/docker-mac-net-connect

# docker-tomcat-tutorial
- A basic tutorial on running a web app on Tomcat using Docker https://www.softwareyoga.com/docker-tomact-tutorial/

## Links
[Sample Tomcat web app](https://tomcat.apache.org/tomcat-8.0-doc/appdev/sample/)


# GIT
## create a remote repository from the current directory ( brew install gh )
- gh repo create Azure_App_Service --public --source=. --remote=upstream

## push
- git init -b main
- git add .
- git status
- git commit -m "first commit"
- git branch -M main
- git remote add origin https://github.com/bhr-private/Azure_App_Service.git
- git push -u origin main

## Change Code & Commit
- git config pull.rebase false


# DOCKER
## Image
- docker build -f Dockerfile --platform linux/amd64 -t tomcat-sample-x64 . 
- docker inspect tomcat-sample-x64 | grep Architecture
        "Architecture": "amd64",

- apt-get update, apt-get install netcat-traditional vim net-tools wget
- docker ps
- docker commit 715ef32a3a17 tomcat-sample-x64

- docker run -p 80:8080 tomcat-sample-x64
- docker tag tomcat-sample-x64:latest learnrgacr.azurecr.io/tomcat-sample-x64:latest 
- az acr login --name learnrgacr
- docker push learnrgacr.azurecr.io/tomcat-sample-x64:latest

# Azure
- az group create --name learn-rg --location westeurope
- az acr create --resource-group learn-rg --name learnrgacr --sku Basic
- az acr login --name learnrgacr

- Enable Admin OR Managed Identity, Service Principal  !
- az acr update --resource-group learn-rg -n learnrgacr --admin-enabled true
- az acr credential show --resource-group learn-rg -n learnrgacr 

- az appservice plan create --resource-group learn-rg --name tomcat-sample-asp --is-linux
- az webapp create --name tomcat-sample-x64 --plan tomcat-sample-asp --resource-group learn-rg --deployment-container-image-name tomcat-sample-x64:latest

- az webapp config container set --name tomcat-sample-x64 --resource-group learn-rg --docker-custom-image-name learnrgacr.azurecr.io/tomcat-sample-x64:latest --docker-registry-server-url https://learnrgacr.azurecr.io --docker-registry-server-user learnrgacr --docker-registry-server-password HdNYrTH4mkN6VKFeMveqdZKTQZX265Y932jbsSVh4A+ACRCPebFK
- az webapp config appsettings set --resource-group learn-rg --name tomcat-sample-x64 --settings WEBSITES_PORT=8080












# MISC
## Azure Container Apps, Azure Container Instances, Azure App Services
https://learn.microsoft.com/en-us/azure/container-apps/compare-options

Azure Container Apps
= serverless microservices, general purpose containers, powered by kubernetes

Azure Container Instances
= single pod of Hyper-V isolated containers on demand, Concepts like scale, load balancing, and certificates are not provided 

Azure App Services
= fully managed hosting for web applications

## Managed Identity 
az webapp identity assign --resource-group learn-rg --name nginx-v2 --query principalId --output tsv
4d95c09f-5036-4d73-9b45-b00af41e77f9

az acr show --resource-group learn-rg --name learnrgacr --query id --output tsv
/subscriptions/8db9a596-7fac-4304-8339-d7e866ddeaeb/resourceGroups/learn-rg/providers/Microsoft.ContainerRegistry/registries/learnrgacr

az role assignment create --assignee 4d95c09f-5036-4d73-9b45-b00af41e77f9 --scope /subscriptions/8db9a596-7fac-4304-8339-d7e866ddeaeb/resourceGroups/learn-rg/providers/Microsoft.ContainerRegistry/registries/learnrgacr --role "AcrPull"

az webapp config set --resource-group learn-rg --name nginx-v2 --generic-configurations '{"acrUseManagedIdentityCreds": true}'






- git clone https://github.com/softwareyoga/docker-tomcat-tutorial.git
- add ssh https://www.cyberciti.biz/faq/how-to-install-openssh-server-on-alpine-linux-including-docker/

https://medium.com/@alexander.volminger/ci-cd-for-java-maven-using-github-actions-d009a7cb4b8f

az webapp create-remote-connection --subscription 8db9a596-7fac-4304-8339-d7e866ddeaeb --resource-group learn-rg -n tomcat-sample-x64 &
az webapp config set --resource-group learn-rg -n tomcat-sample-x64 --remote-debugging-enabled=false
