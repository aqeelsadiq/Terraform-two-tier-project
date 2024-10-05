aws-region        = "select-region"
resource-name     = "any-name"
vpc-cidr          = "10.0.0.0/16"
ec2-ami           = "ami-0d53d7"
ec2-instance-type = "t2.micro"
pub-subnet = [
  {
    name              = "your-subnet-name"
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-west-1a"
  },
  {
    name              = "your-subnet-name"
    cidr_block        = "10.0.2.0/24"
    availability_zone = "us-west-1c"
  }
]

pri-subnet = [
  {
    name              = "your-subnet-name"
    cidr_block        = "10.0.3.0/24"
    availability_zone = "us-west-1a"
  },
  {
    name              = "your-subnet-name"
    cidr_block        = "10.0.4.0/24"
    availability_zone = "us-west-1c"
  }
]
