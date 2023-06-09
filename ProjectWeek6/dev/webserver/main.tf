
# Module to deploy basic networking 
module "webserver-dev" {
  source = "../../../modules/aws_webserver"
  #source              = "git@github.com:Dhansca/aws_network.git"
  default_tags  = var.default_tags
  prefix        = var.prefix
  env           = var.env
  instance_type = var.instance_type

  bucket_name       = "group-17-s3-bucket1"
  remote_bucket_key = var.remote_bucket_key

  webserver_project_path = "/home/ec2-user/environment/ProjectWeek6/dev/webserver/"
  webserver_key_path     = "/home/ec2-user/environment/ProjectWeek6/dev/webserver/"
}







