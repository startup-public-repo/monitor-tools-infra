resource "aws_security_group" "ec2_security_group" {
  description  = "server instance security group"
  name         = "${var.name}-sg"
  vpc_id       =  data.aws_vpc.vpc_id.id


# ingress
dynamic "ingress" {
  for_each = var.ingress_ports
  content {
    from_port   = tonumber(split("-",ingress.value.port)[0])
    to_port     = tonumber(split("-",ingress.value.port)[length(split("-",ingress.value.port))-1]) 
    protocol    = "TCP" 
    cidr_blocks = ["0.0.0.0/0"]#tostring(data.aws_vpc.vpc_id.cidr_block) change this to private ip
  }
}
egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

  tags = {
    Name="${var.name}-sg"
  }
}