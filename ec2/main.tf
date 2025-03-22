resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip
  vpc_security_group_ids      = var.security_group_ids

  key_name                    = var.key_name != "" ? var.key_name : null
  user_data                   = var.user_data != "" ? var.user_data : null
  iam_instance_profile        = var.iam_instance_profile != "" ? var.iam_instance_profile : null

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  tags = merge({
    Name = var.name
  }, var.tags)
}
