# rds.tf

/*provider "aws" {
  region = "us-east-2"  # Cambia a tu región si es necesario
}*/

# Crear grupo de seguridad para RDS
resource "aws_security_group" "rds_security_group" {
  vpc_id = module.vpc.vpc_id #var.vpc_id

  # Permitir el tráfico desde tu dirección IP
  ingress {
    from_port   = 3306 # Puerto para MySQL
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.my_ip] # Permitir tu IP personal
  }

  # Permitir el tráfico desde nodos en la red privada
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = module.vpc.private_subnets_cidr_blocks #var.subnet_ids  # Permitir acceso desde las subredes privadas
  }

  tags = {
    Name = "RDS Security Group"
  }
}

# Crear instancia RDS MySQL
resource "aws_db_instance" "example" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_type
  db_subnet_group_name   = aws_db_subnet_group.example.name
  multi_az               = var.multi_az
  identifier             = "cloudappdb"
  username               = "admin"
  password               = "12345678" # Cambia esto a una contraseña segura
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_security_group.id] # Asociar el grupo de seguridad

  tags = {
    Name = "My RDS Instance"
  }
}

# Crear grupo de subredes para RDS
resource "aws_db_subnet_group" "example" {
  name       = "my-db-subnet-group"
  subnet_ids = module.vpc.private_subnets #["subnet-04398b2aec0d96736", "subnet-0175569b89ca8b0e2"]

  tags = {
    Name = "My DB Subnet Group"
  }
}