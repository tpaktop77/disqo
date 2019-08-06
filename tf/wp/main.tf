data "aws_caller_identity" "current" {
}

module "vpc" {
	source = "./modules/vpc"
    env = "${var.env}"
    app = "${var.app}"

}

module "asg" {
    source = "./modules/asg"
    region = "${var.region}"
    env = "${var.env}"
    app = "${var.app}"
    asg_min_size = "1"
    asg_max_size = "1"
}