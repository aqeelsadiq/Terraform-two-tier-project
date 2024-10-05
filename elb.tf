#ELB

resource "aws_lb" "load-balancer" {
  name               = "${var.resource-name}-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.webserver-sg.id]
  subnets            = [aws_subnet.pub-subnet1[0].id, aws_subnet.pub-subnet1[1].id]
}

resource "aws_lb_target_group" "TG" {
  name     = "${var.resource-name}-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main-vpc.id

}

resource "aws_lb_listener" "Listener" {
  load_balancer_arn = aws_lb.load-balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG.arn
  }
  depends_on = [aws_lb.load-balancer, aws_lb_target_group.TG]
}

resource "aws_lb_target_group_attachment" "Instance-attachment" {
  count            = length(aws_instance.webserver)
  target_group_arn = aws_lb_target_group.TG.arn
  target_id        = aws_instance.webserver[count.index].id
  port             = "80"
}