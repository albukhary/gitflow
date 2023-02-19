module "vpc" {
  source = "../../modules/vpc"
}

module "sg" {
  source = "../../modules/sg"
  vpc            = module.vpc.vpc
  subnet_private = module.vpc.subnet_private
}

module "ec2" {
  source             = "../../modules/ec2"
  region             = var.region
  ami                = var.ami
  subnet_public_id   = module.vpc.public_subnet_id
  subnet_private_id  = module.vpc.private_subnet_id
  subnet_database_id = module.vpc.database_subnet_id
  sg_bastion_id      = module.sg.sg_bastion_id
  sg_public_id       = module.sg.sg_public_id
  sg_private_id      = module.sg.sg_private_id
  sg_database_id     = module.sg.sg_database_id
  ec2_user           = var.EC2_USER
}