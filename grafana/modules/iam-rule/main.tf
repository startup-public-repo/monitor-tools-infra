resource "aws_iam_role" "instance_role" {
    name     =  "${var.name}-iam-role"
    assume_role_policy = jsonencode({
        Version ="2012-10-17"
        Statement=[
           {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }, 
        ]
    })
  tags = {
    Name="${var.name}-iam-role"
  }
}
resource "aws_iam_policy_attachment" "instance_policy_attachment" {
    count = length(var.policy_name)
    name= "${var.name}-policy-attachment"
    roles = [aws_iam_role.instance_role.name]
    policy_arn = "arn:aws:iam::aws:policy/${var.policy_name[count.index]}"
}
resource "aws_iam_instance_profile" "aws_iam_instance_profile" {
    name = "${var.name}-iam-instance-profile"
    role = aws_iam_role.instance_role.name
}