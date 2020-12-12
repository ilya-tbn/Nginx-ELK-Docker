#Create our EC2 instance.
resource "aws_instance" "docker" {
    ami = lookup(var.AMI, var.awsRegion)
    instance_type = var.instanceType
    subnet_id = aws_subnet.subnet-10-0-101.id
    vpc_security_group_ids = [aws_security_group.docker-sg.id]
    key_name = aws_key_pair.docker-key.id
    #Copy the Docker configuration files to the vm, and execute the installer.
    provisioner "file" {
        source = "../Docker"
        destination = "/tmp/docker_setup"
    }
    provisioner "remote-exec" {
        inline = [
             "chmod +x /tmp/docker_setup/install.sh",
             "sudo /tmp/docker_setup/install.sh"
        ]
    }
    connection {
        user = var.ec2User
        private_key = file(var.privateKey)
        host = self.public_ip
    }
}
#Public key used to connect to the instance.
resource "aws_key_pair" "docker-key" {
      key_name = "docker-key"
      public_key = file(var.publicKey)
}
#Associate our Instance with the Elastic IP we created.
resource "aws_eip_association" "eip" {
  instance_id   = aws_instance.docker.id
  allocation_id = aws_eip.dockerEip.id
}