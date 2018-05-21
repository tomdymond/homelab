package test

import (
	"fmt"
	"testing"
	"time"

	//"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

// An example of how to test the Terraform module in examples/terraform-http-example using Terratest.
func TestTerraformHttpExample(t *testing.T) {
	t.Parallel()

	// A unique ID we can use to namespace resources so we don't clash with anything already in the AWS account or
	// tests running in parallel
	uniqueID := random.UniqueId()

	// Give this EC2 Instance and other resources in the Terraform code a name with a unique ID so it doesn't clash
	// with anything else in the AWS account.
	instanceName := fmt.Sprintf("terratest-http-example-%s", uniqueID)

	// Specify the text the EC2 Instance will return when we make HTTP requests to it.
	instanceText := fmt.Sprintf("Hello, %s!", uniqueID)

	// Pick a random AWS region to test in. This helps ensure your code works in all regions.
	//awsRegion := aws.GetRandomRegion(t, nil, nil)
        awsRegion := "us-east-1"

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
                //TerraformDir: "/Users/tdy02/go/src/github.com/gruntwork-io/terratest/examples/terraform-http-example",
                TerraformDir: "../terraform",
		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"aws_region":    awsRegion,
			"instance_name": instanceName,
			"instance_text": instanceText,
                        "database_password": "foobar",
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	instanceURL := terraform.Output(t, terraformOptions, "instance_url")

	// It can take a minute or so for the Instance to boot up, so retry a few times
	maxRetries := 15
	timeBetweenRetries := 30 * time.Second

        crudUrlWrite := fmt.Sprintf("%s/create?email=tom@foo.com&name=tom", instanceURL)      
        crudUrlRead := fmt.Sprintf("%s/get-by-email?email=tom@foo.com", instanceURL)      
        crudUrlUpdate := fmt.Sprintf("%s/update?id=1&email=foo@foo.com&name=john", instanceURL)
        crudUrlDelete := fmt.Sprintf("%s/delete?id=1", instanceURL)      

        crudUrlWriteinstanceText := "User succesfully created! (id = 1)"
        crudUrlReadinstanceText := "The user id is: 1"
        crudUrlUpdateinstanceText := "User successfully updated!"
        crudUrlDeleteinstanceText := "User successfully deleted!"

	// Verify that we get back a 200 OK with the expected instanceText
	http_helper.HttpGetWithRetry(t, crudUrlWrite, 200, crudUrlWriteinstanceText, maxRetries, timeBetweenRetries)
	http_helper.HttpGetWithRetry(t, crudUrlRead, 200, crudUrlReadinstanceText, maxRetries, timeBetweenRetries)
	http_helper.HttpGetWithRetry(t, crudUrlUpdate, 200, crudUrlUpdateinstanceText, maxRetries, timeBetweenRetries)
	http_helper.HttpGetWithRetry(t, crudUrlDelete, 200, crudUrlDeleteinstanceText, maxRetries, timeBetweenRetries)
}
