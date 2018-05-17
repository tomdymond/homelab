package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the Terraform module in examples/terraform-aws-example using Terratest.
func TestTerraformAwsExample(t *testing.T) {
	t.Parallel()

	// Give this EC2 Instance a unique ID for a name tag so we can distinguish it from any other EC2 Instance running
	// in your AWS account
	expectedName := fmt.Sprintf("terratest-aws-example-%s", random.UniqueId())

	// Pick a random AWS region to test in. This helps ensure your code works in all regions.
	awsRegion := aws.GetRandomRegion(t, nil, nil)

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "terraform/",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"instance_name": expectedName,
		},

		// Environment variables to set when running Terraform
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	instanceId := terraform.Output(t, terraformOptions, "instance_id")

	// Look up the tags for the given Instance ID
	instanceTags := aws.GetTagsForEc2Instance(t, awsRegion, instanceId)

	// Verify that our expected name tag is one of the tags
	nameTag, containsNameTag := instanceTags["Name"]
	assert.True(t, containsNameTag)
	assert.Equal(t, expectedName, nameTag)
}
