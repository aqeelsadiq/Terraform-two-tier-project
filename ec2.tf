# EC2

resource "aws_security_group" "webserver-sg" {
  vpc_id = aws_vpc.main-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_key_pair" "mykey-tf" {
  key_name   = "mykeyaq-tf"
  public_key = file("${path.module}/id_rsa.pub")

}

resource "aws_instance" "webserver" {
  count                       = 2
  ami                         = var.ec2-ami
  instance_type               = var.ec2-instance-type
  vpc_security_group_ids      = [aws_security_group.webserver-sg.id]
  subnet_id                   = aws_subnet.pub-subnet1[count.index].id
  key_name                    = aws_key_pair.mykey-tf.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${var.resource-name}-wp"
  }
  user_data = file("${path.module}/user_data.sh")
}