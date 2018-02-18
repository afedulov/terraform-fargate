# DS lab support VPC

This repository contains the files needed to setup the support VPC for the DSLab.

The support VPC can be setup using terraform and running the commands:

```
cd terraform
terraform init
terraform apply
```

If you would want to create a custom environment:
* Modify `vars.tf` and change ENV variable from `"PROD"` to `"%%YOUR_ENV%%"`. Change key of S3 bucket from `"terraform.tfstate"` to `"terraform-%%YOUR_ENV%%.tfstate"`.

##Pushing images to ECR

* `docker build -t myapp .`
* `docker tag myapp:latest 861472724426.dkr.ecr.us-east-1.amazonaws.com/myapp:latest` , where myapp has to be a repository in the `ecr.tf` file and `861472....amazonaws.com` is repos URL
* `$(aws ecr get-login --region us-east-1 --no-include-email)`
* `docker push 861472724426.dkr.ecr.us-east-1.amazonaws.com/myapp:latest`


## To Do List

A list of things that need to be done in approximate order of importance:

* Understand IP routing to public internet, cant seem to reach public IP of EC2 instance
* Use docker images from ECR, not the public ones directly
* Setup access to GitLab -- push and pull repos
* Ensure data is saved in gitlab after a reboot
* Use certs in gitlab from the AWS SSL service
* Setup openvpn to access private subnets
* EC2 instance is in the public subnet, needs to be moved to private after the openvpn has been setup
* Look at security groups and subnet ACLs, secure from outside
* Understand if any IAM roles are too generous
* Use a bastion? -- is this the same as the VPC module provides if we have no public subnets?
* Fix encryption of logs in cloudwatch -- couldnt set up an new key on KMS to encrypt the logs
* Is an autoscaling group better than a straight EC2 instance on the ECS cluster?
* Enable locking of terraform state with dynamodb
* Ensure eveything that can be tagged is tagged
* Setup chrony (in place of the older ntp) using the new aws time service avilable on 169.254.169.123, will need outward (but not internet) UDP/123 access to the EC2 instance

## Features

* VPC created with private and public subnets
* docker images running on ECS
* docker logs going to cloudwatch
* DNS entries created for ALB
* ALB handling HTTPS requests to docker images
* AWS managed SSL certificate generation


## Planned support services

* OpenVPN
* GitLab (running, but probably doesnt work)
* artifactory

I was thinking about jenkins for CI, but why not use gitlab CI instead.
We may need a jenkins-worker docker container running.

Since we are going for SSO/AD integration we wont be needing openldap, password reset or phpldapadmin.
