#------asg/main.tf-----

resource "aws_placement_group" "test_pg" {
  name     = "test_pg"
  strategy = "cluster"
}








data "aws_ami" "server_ami" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
}


resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "terraform-lc-example-"
  image_id      = "${data.aws_ami.server_ami.id}"
  instance_type = "t2.micro"
  security_groups = ["${var.tf_public_sg}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "test_asg" {
  name                 = "test_asg"
  launch_configuration = "${aws_launch_configuration.as_conf.name}"
#  alb_target_group_arn   = "${var.lb_tg_arn}"
  min_size             = 1
  max_size             = 2
  desired_capacity          = 2
#  elb                    = "${var.lb}"
  placement_group     = "${aws_placement_group.test_pg.id}"
  vpc_zone_identifier   = ["${var.tf_public_subnet}"]
  health_check_type    = "ELB"
  health_check_grace_period = 300
  force_delete              = true
  target_group_arns         = ["${var.lb_tg_arn}"]


  lifecycle {
    create_before_destroy = true
  }
}
