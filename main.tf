provider "aws" {
  region = "ap-south-1"
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Generate random number for unique S3 bucket
resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}

# Create S3 bucket (must be globally unique)
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "jenkins-terraform-demo-${random_integer.suffix.result}"

  tags = {
    Name = "jenkins-demo-bucket"
  }
}

# Create EC2 instance in default VPC
resource "aws_instance" "ec2" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"

  tags = {
    Name = "jenkins-terraform-demo"
  }
}
