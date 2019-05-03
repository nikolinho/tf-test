#-------------rds/main.tf-------

resource "aws_db_instance" "test_rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "${var.dbtype}"
  engine_version       = "${var.engine_version}"
  instance_class       = "${var.db_instance_class}"
  name                 = "${var.db_name}"
  username             = "${var.db_username}"
  password             = "${var.db_password}"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = "true"
  deletion_protection  = "false"
  port                  = "3306"
  db_subnet_group_name = "${aws_db_subnet_group.subnets.id}"
  vpc_security_group_ids = ["${var.tf_public_sg}"]
}

resource "aws_db_subnet_group" "subnets" {
  name       = "subnets"
  subnet_ids = ["${var.subnets}"]

  tags = {
    Name = "Subnet 4 DB"
  }
}