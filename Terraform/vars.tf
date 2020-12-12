#Region settings.
variable "awsRegion" {    
    default = "eu-west-2"
}
variable "awsAZ" {    
    default = "eu-west-2a"
}
#Instance type. This one is for Centos8 in eu-west. change whatever you like here.
variable "AMI" {
  type = map
  default = {
    eu-west-2 = "ami-00c89583fee7b879d"
  }
}
variable "instanceType" {
  default = "t3a.medium"
}

#For connection to the instance and installation of all the components.
variable "privateKey" {
  default = "docker-key"
}
variable "publicKey" {
  default = "docker-key.pub"
}
variable "ec2User" {
  default = "centos"
}
