
resource "aws_instance" "bastion_nat" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.keypair
  subnet_id = var.subnet_id
  vpc_security_group_ids = [var.security_groups_ids]
  associate_public_ip_address = true 
  source_dest_check = false
  user_data = file("${path.module}/nat_instance.sh")
  root_block_device {
    volume_size = 10
    volume_type = "gp2"
    delete_on_termination = true
  }
  tags = {
    Name = "bastion-nat" 
 }
}

resource "aws_eip" "nat_eip" {
   instance = aws_instance.bastion_nat.id
   domain = "vpc"
   depends_on = [aws_instance.bastion_nat]
   tags = {
     Name = "nat-eip"
   }
}