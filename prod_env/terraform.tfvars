aws_region = "us-east-1"
project_name = "la-terraform"
vpc_cidr = "10.123.0.0/16"
public_cidrs = [
    "10.123.1.0/24",
    "10.123.2.0/24"
    ]
accessip = "0.0.0.0/0"
key_name = "tf_key" 
public_key_path = "/home/ec2-user/.ssh/id_rsa.pub"
server_instance_type = "t2.micro" 
instance_count = 1
dbtype = "mysql"
engine_version = 5.7
db_instance_class = "db.t2.micro"
db_name = "mydb"
db_username = "dbuser"
db_password = "superSecurePassword"
env = "prod"