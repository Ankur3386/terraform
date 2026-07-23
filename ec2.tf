resource "aws_key_pair" "ank_key"{
key_name= "ankur_key"
public_key= file("terra.pub")
}


resource "aws_default_vpc" "default"{


}


resource "aws_security_group" "sub"{
vpc_id = aws_default_vpc.default.id
name= "ank"
description=" this is a security group with default vpc"
ingress{
  description="allow http"
  from_port= 80
  to_port= 80
  protocol= "tcp"
  cidr_blocks= ["0.0.0.0/0"]
}

ingress{
  description="allow ssh"
  from_port= 22
  to_port= 22
  protocol= "tcp"
  cidr_blocks= ["0.0.0.0/0"]
}

ingress{
  description="allow https"
  from_port= 443
  to_port= 443
  protocol= "tcp"
  cidr_blocks= ["0.0.0.0/0"]
}

egress{
description=" to where traffic go"
to_port=0
from_port=0
protocol= "-1"
cidr_blocks= ["0.0.0.0/0"]
}

tags={
Name= "ank-security-group"
}

}

resource "aws_instance" "ec2"{
key_name= aws_key_pair.ank_key.key_name
ami= "ami-0b6d9d3d33ba97d99"
security_groups= [aws_security_group.sub.name]
instance_type= var.ec2_instance
root_block_device{
 volume_size =15
 volume_type = "gp3"
}
tags={
  Name= "ankur_ec2"
}
}
