Hello Team,

PFA the Technical Task.

1.Create GitHub repository
2.Add docker file code to create image of following operation ( Read data from s3 and push it to RDS and if RDS not possible push it to Glue Database) and deploy this image to AWS ECR (Use python program and create docker image using that file )
3.Create lambda function using this image and test it.

Note:

1-Use Jenkins CI/CD pipeline for code deployment and all resource creation (All resources terraform codes , docker image creation code)
2- Also create required resources(AWS Services) through terraform code
3- Add screenshots of all output windows like Jenkins , Terraform resource creation , DB , lambda function output.

******************************************************************************************************************************************************************************************************

***** Here the steps I used to accomplish this Task *****
1) Create AWS Account.
2) Create IAM user and pull Access and Security Key.
3) Create specific IAM roles required for this Task.
4) Download AWS CLI and Terraform.
5) setup AWS CLI and Terraform.
6) After that provie AWS Authentication by using AWS CLI.
7) After That Create one instance Manually for Docker and Jenkins Setup.
8) SSH login in server and download jenkins.
9) Configure jenkins and map the jenkins on 8080 port. (for this we need to add 8080 port in security group.)
10) after that login jenkins by using localhost( ip-address-of-instance:8080) and create jenkins user and download all plugins like( git integration, AWS integration, Docker integration, Pipeline tree, SCM).
11) After agin in this AWS server install Docker and configure docker.
12) docker install same server in which jenkins server.
13) provide all docker permission to jenkins by using command. (sudo usermod -aG docker jenkins)
14) login jenkins portal and configure all credentials like AWS access key and security key.
15) after that on lacal machie create ECR.tf file to first create AWS ECR.
16) after that create git repository (public).
17) and setup all configuration coding folders and files in this repository which required to accomplish this task.
18) after that on jenkins portal create pipeline job in this job add SCM( git repository link).
19) and build job.
20) after successfully job build in AWS instance check /var/lib/jenkins path all configuration file automatically push on this path.
21) after that trigger lambda function to read data from S3 bucket.


Thanks...........



22) 
