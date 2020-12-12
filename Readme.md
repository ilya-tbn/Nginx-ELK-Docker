POC - Dockerized Nginx and ELK stack.



Tested using CentOS 8.3 as the Docker host.

This project has 2 folders:

1.Terraform. Everything you need to automatically install this project on AWS. I used v0.13.5 to run this.

2.Docker. Container configuration files for all the docker images.


Installation Instructions:
- Copy your website content to /Docker/nginx/website
- Install:
  - There are three ways to install everything:
    1. Manually copy the Docker folder to a preinstalled Linux server of your choosing, and execute "install.sh" with root privileges.

    2. Use the provided Terraform files.
      - Create a new key-pair called "docker-key" and "docker-key.pub" and place them in the Terraform folder.
      - Make sure you have your AWS access and secret keys configured in your environment variables, otherwise you can configure them manually in "provider.tf"
      - Change the region and instance type to whatever you require in "vars.tf". 3GB of RAM is a minimum for this setup for now.
      - Execute "terraform init" and "terraform apply" from the Terraform folder.
      - Go for a coffee break. This will take a few minutes


Issues:
- Nginx logs are being forwarded as part of a message field from the Docker log. Need to figure out how to remove all the extra data and keep only the Nginx access log.

ToDo:
- Implement Ansible playbook installation

