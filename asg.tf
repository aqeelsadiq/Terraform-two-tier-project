#Autoscaling

resource "aws_launch_template" "template" {
  name_prefix   = "${var.resource-name}-asg"
  image_id      = var.ec2-ami
  instance_type = var.ec2-instance-type
  key_name      = aws_key_pair.mykey-tf.key_name
  user_data     = filebase64("${path.module}/user_data.sh")

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.webserver-sg.id]
  }
  
  tag_specifications {
    resource_type = "instance"

    tags = { 
      Name = "launch-template-webserver"
    }
  }

}

resource "aws_autoscaling_group" "asgaqeel" {
  name                      = "${var.resource-name}-autoscaling"
  count                     = length(var.pub-subnet)
  desired_capacity          = 2
  max_size                  = 6
  min_size                  = 2
  health_check_type         = "ELB"
  health_check_grace_period = 300
  vpc_zone_identifier       = tolist(aws_subnet.pub-subnet1[*].id)
  target_group_arns = [aws_lb_target_group.TG.arn]

  launch_template {
    id = aws_launch_template.template.id
  }
}

resource "aws_autoscaling_policy" "target-traacking-policy" {
  name                   = "${var.resource-name}-target-tracking"
  count                  = length(var.pub-subnet)
  autoscaling_group_name = aws_autoscaling_group.asgaqeel[count.index].id
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50
  }
}