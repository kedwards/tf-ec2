resource "aws_instance" "this" {
  count = var.create_instance ? var.instance_count : 0

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.provisioning_key
  subnet_id              = var.subnets[0]
  vpc_security_group_ids = var.security_groups
  user_data              = var.user_data

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
  }

  tags = merge(
    {
      "Name" = format("%s-instance", var.name)
    },
    var.tags,
    var.instance_tags
  )
}

resource "aws_key_pair" "this" {
  count = var.create_key_pair ? 1 : 0

  key_name   = var.provisioning_key
  public_key = var.public_key
}

resource "aws_launch_configuration" "this" {
  count = var.create_instance ? 0 : 1
  # Launch Configurations cannot be updated after creation with the AWS API.
  # In order to update a Launch Configuration, Terraform will destroy the
  # existing resource and create a replacement.
  #
  # We're only setting the name_prefix here,
  # Terraform will add a random string at the end to keep it unique.
  associate_public_ip_address = var.associate_public_ip_address
  enable_monitoring           = var.enable_monitoring
  image_id                    = var.ami
  instance_type               = var.instance_type
  key_name                    = var.provisioning_key
  security_groups             = var.security_groups
  user_data                   = var.user_data

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  count = var.create_instance ? 0 : 1

  # Force a redeployment when launch configuration changes.
  # This will reset the desired capacity if it was changed due to
  # autoscaling events.
  name = "${aws_launch_configuration.this[0].name}-asg"

  desired_capacity          = var.desired_capacity
  health_check_grace_period = 300
  health_check_type         = var.health_check_type
  launch_configuration      = aws_launch_configuration.this[0].id
  max_size                  = var.max_size
  min_size                  = var.min_size
  vpc_zone_identifier       = var.vpc_zone_identifier

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags

  provisioner "local-exec" {
    command = "./get_ips.sh"
  }
}

resource "aws_autoscaling_attachment" "this" {
  count = (false == var.create_instance && var.create_alb) ? 1 : 0

  autoscaling_group_name = aws_autoscaling_group.this[0].id
  alb_target_group_arn   = aws_alb_target_group.this[0].arn
}

resource "aws_lb" "this" {
  count = (false == var.create_instance && var.create_alb) ? 1 : 0

  name               = "${var.name}-lb"
  internal           = var.internal_lb ? true : false
  load_balancer_type = var.load_balancer_type
  security_groups    = var.alb_security_groups
  subnets            = var.subnets

  tags = merge(
    {
      "Name" = format("%s-aws-lb", var.name)
    },
    var.tags,
    var.alb_tags,
  )
}

resource "aws_alb_target_group" "this" {
  count = (false == var.create_instance && var.create_alb) ? 1 : 0

  name     = "${var.name}-lb-tg"
  port     = var.target_group_port
  protocol = var.protocol
  vpc_id   = var.vpc_id
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = var.path
    port                = var.target_group_port
  }

  tags = {
    name = "${var.name}-lb-tg"
  }
}

resource "aws_alb_listener" "this" {
  count = (false == var.create_instance && var.create_alb) ? 1 : 0

  load_balancer_arn = aws_lb.this[0].arn
  port              = 80
  protocol          = var.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this[0].arn
  }
}

resource "aws_alb_listener_rule" "this" {
  count = (false == var.create_instance && var.create_alb) ? 1 : 0

  listener_arn = aws_alb_listener.this[0].arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this[0].id
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  depends_on = [aws_alb_target_group.this[0]]
}