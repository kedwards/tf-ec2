resource "aws_instance" "this" {
  count = var.instance_count > 0 ? var.instance_count : 0

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.provisioning_key
  subnet_id              = var.subnet
  vpc_security_group_ids = var.security_groups
  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
  }
  user_data = var.user_data

  tags = merge(
    {
      "Name" = format("%s-instance", var.name)
    },
    var.tags,
    var.instance_tags
  )
}