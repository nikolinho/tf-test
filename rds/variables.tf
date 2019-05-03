variable "subnets" {
    type = "list"
}

variable "dbtype" {}

variable "engine_version" {}

variable "db_instance_class" {}

variable "db_name" {}

variable "db_username" {}

variable "db_password" {}

variable "tf_public_sg" {
    type = "list"
}
