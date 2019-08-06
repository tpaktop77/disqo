data "aws_caller_identity" "current" {
}

module "vpc" {
	source = "./modules/vpc"
    env = "${var.env}"
    app = "${var.app}"
}

module "iam" {
	source = "./modules/iam"
    env = "${var.env}"
    app = "${var.app}"
}

module "alb" {
	source = "./modules/alb"
    env = "${var.env}"
    app = "${var.app}"
    vpc_id = "${module.vpc.vpc_id}"
    public_subnets = "${module.vpc.public_subnets}"
}

module "asg" {
    source = "./modules/asg"
    region = "${var.region}"
    env = "${var.env}"
    app = "${var.app}"
    asg_min_size = "1"
    asg_max_size = "1"
    instance_profile = "${module.iam.instance_profile}"
    vpc_id = "${module.vpc.vpc_id}"
    alb_sg_id = "${module.alb.alb_sg_id}"
}