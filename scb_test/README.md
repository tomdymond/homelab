# Test AWS stack

The following application is used for testing:

https://github.com/netgloo/spring-boot-samples/tree/master/spring-boot-mysql-springdatajpa-hibernate


## Prerequisites

Create a file `secrets.tfvars` with the following information

```
aws_access_key = "ACCESSKEY"
aws_secret_key = "SECRETKEY"
database_password = "DBPASSWORD"
```

Replace the value for `key_name` to be the one you have configured in AWS for the region in `modules/globals/vars.tf`

```
variable key_name {
  default = "tom-aws-virginia"
}
```

## Deploy the environment

Type `make apply` (This will run a `terraform apply` including two necessary var files)


Once terraform has completed, get the public DNS record

```
$ terraform state show module.vpc.aws_elb.my-elb | grep dns_name
dns_name                               = my-elb-66207154.us-east-1.elb.amazonaws.com
```

Check the URL responds properly. It may take up to 5 minutes to be ready.

```
$ curl my-elb-66207154.us-east-1.elb.amazonaws.com
Proudly handcrafted by <a href='http://netgloo.com/en'>Netgloo</a> :)
```

## Testing CRUD:

Create:
```
curl my-elb-66207154.us-east-1.elb.amazonaws.com/create?'email=tom@foo.com&name=tom'
User succesfully created! (id = 1)
```

Read: 
```
curl my-elb-66207154.us-east-1.elb.amazonaws.com/get-by-email?'email=tom@foo.com'
The user id is: 1
```

Update:
```
curl my-elb-66207154.us-east-1.elb.amazonaws.com/update?'id=1&email=foo@foo.com&name=john'
User successfully updated!
```

Delete:
```
curl my-elb-66207154.us-east-1.elb.amazonaws.com/delete?'id=1'
User successfully deleted!
```


