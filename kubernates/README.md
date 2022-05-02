# Kubernates
# steps to deploy our application on cluster 
![Build Status](https://www.okd.io/img/logo-kubernetes-horizontal-color.png)
- ssh to bastion host vm 
- download kubectl on bastion host vm
 ```sh
        sudo apt update 
        sudo apt install kubectl
```
- download docker on bastion host an configure docker configuration to gcloud on bastion host and reboot vm
```sh
        curl -fsSL https://test.docker.com -o test-docker.sh 
        sudo sh test-docker.sh
        sudo usermod -aG docker ${USER}
        gcloud auth config-docker
        sudo reboot
```
- ssh again to your bastion host vm and configure it to interact with the cluster 
```sh
        gcloud container clusters get-credentials YOUR_CLUSTER_NAME
```
- create 4 yml file on pastion host : 2 for web-app deployment and service and 2 for redis deployment and service
- at first run the deployment and service of redis 
  ```sh
        kubectl apply -f redis-deployment.yml
        kubectl apply -f redis-service.yml
```
- then assign redis service generated ip to env variables of web-app-deployment.yml 
- then run the deployment and service of webapp
 ```sh
        kubectl apply -f web-app-deployment.yml
        kubectl apply -f web-app-service.yml
```
- then hit the browser of web-app on browser by using web-app-servise external ip to show the following screen 
![Build Status](https://github.com/sambo2021/GCP-Terraform-Kubernates-Task/blob/main/screen-shots/web-app.png?raw=true)






