# Terraform
# steps to initialize gcp infrastructure through terraform
![Build Status](https://assets-global.website-files.com/5ceab5395d0f478e169de7c0/5fd61d7fd7b9bf195b1680d5_Terraform.png)
- in provider terraform file define project and region 
- create a vpc with disabling auto_create_subnetworks
- create first subnet with cidr range "10.1.0.0/24" under name of public  
- create a router resource and nat getway , attach public subnet  to that nat getway to act really as public subnet 
- create second subnet with cidr range "10.2.0.0/24" under name of private
  called private subnet cause there is no nat attached to it so it cannot connect public internet 
- create a fire wall that allowing port 80 for ssh out instance  
- create secondry cidr ranges in private subnet to later attache them to cluster pods and services
  for "k8s-pod-range" ip_cidr_range = "10.3.0.0/20"
  for "k8s-service-range" ip_cidr_range = "10.4.0.0/20"
  note: recommended to not use range lower than defined in previous ranges
        to avoid problem of exhausted ip ranges allocation
- create an instance and attach it to public subnet to act later as a bastion host 
- create a regional private container cluster with 2 node locations 
- - attach cluster to vpc and private subnet 
- - make its nodes and endpoints private 
- - attach master_ipv4_cidr_block = "172.16.0.0/28" for master plan 
- - attach secondry private subnet ip ranges for pods and services
      cluster_secondary_range_name = "k8s-pod-range"
      services_secondary_range_name = "k8s-service-range"
- create node pool 
- - define a location for my ex : location = "us-central1"
- - define node count for my ex : node_count = 1  that means one node for each node location 
- - then define node machine specs 
       machine_type = "e2-micro"
       disk_size_gb = 10
- - sevice account : is the most important part in that project 
    define a service account and attach 2 roles to this service account 
    first role container.admin
    second role storage.objectAdmin 
    and definetly define this service account for each instance in our project 
    for our project instance created in public subnet and node bool in cluster 

## Commands to initialize gcp infrastructure through terraform

```sh
terraform init 
terraform plan
terraform apply 
```
> Note: now all infrastracture initialized on your GCP project 

## GCP Console Sanpshots
### Private Cluster 
![Build Status](https://github.com/sambo2021/GCP-Terraform-Kubernates-Task/blob/main/screen-shots/cluster.png?raw=true)
### Bastion host and nodes created 
![Build Status](https://github.com/sambo2021/GCP-Terraform-Kubernates-Task/blob/main/screen-shots/instances.png?raw=true)
### VPC
![Build Status](https://github.com/sambo2021/GCP-Terraform-Kubernates-Task/blob/main/screen-shots/vpc.png?raw=true)
### NAT GateWay
![Build Status](https://github.com/sambo2021/GCP-Terraform-Kubernates-Task/blob/main/screen-shots/nat.png?raw=true)





