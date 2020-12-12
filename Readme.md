Readme.md

POC - Dockerized Nginx and ELK stack.

Tested on CentOS 8.3

This project has 2 folders:
1.Terraform - everything you need to automatically install this project on AWS.
2.Docker - Container configuration files for all the docker images.


Installation Instructions:
- Copy your website content to /Docker/nginx/website
- Install:
	- There are three ways to install everything:
		1. Manually copy the Docker folder to a preinstalled Linux server of your choosing, and execute "install.sh" with root privileges.

		2. Terraform
		  - Create a new key-pair called "docker-key" and "docker-key.pub" and place them in the Terraform folder.
		  - Make sure you have your AWS access and secret keys configured in your environment variables, otherwise you can configure them manually in "provider.tf"
		  - Change the region and instance type to whatever you want in "vars.tf"
		  - Execute "terraform init" and "terraform apply" from the Terraform folder.
		  - Go for a coffee break. This will take a few minutes


Issues:
- Nginx logs are being forwarded as part of a message field from the Docker log. Need to figure out how to remove all the extra data and keep only the Nginx access log.

ToDo:
- Implement Ansible playbook installation

