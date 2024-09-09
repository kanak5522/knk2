
provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "knk1234" {
  ami           = "ami-04e49d62cf88738f1"
  instance_type = "t2.micro"              
 

  tags = {
    Name = "ExampleInstance42"
  }
}
