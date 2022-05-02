# Docker
# steps to dockerize our python web application
![Build Status](https://icon2.cleanpng.com/20180812/plj/kisspng-docker-microservices-application-software-cloud-co-docker-logo-software-logo-5b706279caa081.27892087153409189783.jpg)
- See the requirements.txt in app folder to be aware of required tornado and redis installation 
- See hello.py to be aware of code you gonna deploy 
- See .env file to be aware of application environmental variables gonna pass through deployment on cluster gke
- Also, we need image redis to be uploaded from local to gcr
- Finally, check the Dockerfile

## Commands to configureDocker & gcloud to work with GCR of your project
#### - enable GCR api 
#### - make sure that your account has all permissions to GCR
#### - install docker on your local machine  
#### - on your local machine make sure that you activated the right account and projcet
```sh
gcloud auth configure-docker
```
## Command used to build image on your local machine 
```sh
docker build -t python .
```
## Command used to push image from local machine to gcr 
```sh
docker tag python gcr.io/sambo-project/front
docker push gcr.io/sambo-project/front
```

```sh
docker pull redis
docker tag redis gcr.io/sambo-project/redis
docker push gcr.io/sambo-project/redis
```
> Note: now there are two images on gcr would by used as container images in 2 deployments on cluster




