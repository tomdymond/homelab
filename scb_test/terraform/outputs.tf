output "instance_url" {
  value = "http://${module.vpc.aws_elb_dns_name}"
}
