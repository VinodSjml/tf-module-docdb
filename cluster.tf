resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "roboshop-${var.ENV}-docdb"
  engine                  = "docdb"
  master_username         = "admin1"
  master_password         = "roboshop1"
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.docdb_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.allows_docdb.id]
  port = 27017
}

resource "aws_db_subnet_group" "docdb_subnet_group" {
  name       = "roboshop-${var.ENV}-docdb-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "roboshop-${var.ENV}-docdb-subnet-group"
  }
}

resource "aws_docdb_cluster_instance" "docdb_instances" {
  count              = 1
  identifier         = "roboshop-${var.ENV}-docdb"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = "db.t3.medium"
}
