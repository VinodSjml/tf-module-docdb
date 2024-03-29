# Creates Security Group For Document DB
resource "aws_security_group" "allows_docdb" {
  name                  = "roboshop-${var.ENV}-documentdb-securitygroup"
  description           = "roboshop-${var.ENV}-documentdb-securitygroup"
  vpc_id                = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
       description      = "DocDB from Private Network"
       from_port        = 27017
       to_port          = 27017
       protocol         = "tcp"
       cidr_blocks      = [data.terraform_remote_state.vpc.outputs.VPC_CIDR , data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
  }

  egress {
       from_port        = 0
       to_port          = 0
       protocol         = "-1"
       cidr_blocks      = ["0.0.0.0/0"]
       ipv6_cidr_blocks = ["::/0"]
  }

    tags = {
      Name = "roboshop-${var.ENV}-documentdb-securitygroup"
    }
}
 