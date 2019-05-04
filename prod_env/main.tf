provider "aws" {
  region = "${var.aws_region}"
}

# Deploy Storage Resource
module "storage" {
  source       = "../storage"
  project_name = "${var.project_name}"
}

# Deploy Networking Resources

module "networking" {
  source       = "../networking"
  vpc_cidr     = "${var.vpc_cidr}"
  public_cidrs = "${var.public_cidrs}"
  accessip     = "${var.accessip}"
}

# Deploy Compute Resources

module "compute" {
  source          = "../compute"
  instance_count  = "${var.instance_count}"
  key_name        = "${var.key_name}"
  public_key_path = "${var.public_key_path}"
  instance_type   = "${var.server_instance_type}"
  subnets         = "${module.networking.public_subnets}"
  security_group  = "${module.networking.public_sg}"
  subnet_ips      = "${module.networking.subnet_ips}"
}

# Deploy Elastic Load Balancer

module "elb" {
  source = "../elb"
  tf_public_sg        = ["${module.networking.public_sg}"]
  tf_public_subnet     = "${module.networking.public_subnets}"
  lb_tg_arn            = "${module.networking.lb_tg_arn}"
  vpc_id               = "${module.networking.vpc_id}"
  env                  = "${var.env}"


}

module "asg" {
  source = "../asg"
  tf_public_sg        = ["${module.networking.public_sg}"]
  tf_public_subnet    = "${module.networking.public_subnets}"
  lb_tg_arn           = "${module.networking.lb_tg_arn}"
  lb                  = "${module.elb.elb_id}"
}

module "rds" {
  source = "../rds"
  subnets             = "${module.networking.public_subnets}"
  dbtype              = "${var.dbtype}"
  engine_version      = "${var.engine_version}"
  db_instance_class   = "${var.db_instance_class}"
  db_name             = "${var.db_name}"
  db_username         = "${var.db_username}"
  db_password         = "${var.db_password}"
  tf_public_sg        = ["${module.networking.public_sg}"]
}