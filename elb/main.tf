#-------------elb/main.tf----------

resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.tf_public_sg}"]
  subnets            = ["${var.tf_public_subnet}"]
#  vpc_id             = "${var.vpc_id}"

  enable_deletion_protection = false
  tags = {
    Environment = "${var.env}"
  }
}



resource "aws_lb_listener" "test" {
  load_balancer_arn = "${aws_lb.test.arn}"
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = "${var.lb_tg_arn}"
  }
}