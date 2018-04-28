all: plan apply

clean:
	rm -rf .terraform

plan:
	terraform plan -var-file=secrets.tfvars -var-file=terraform.tfvars

destroy:
	terraform destroy -var-file=secrets.tfvars -var-file=terraform.tfvars

apply:
	terraform apply -var-file=secrets.tfvars -var-file=terraform.tfvars

init:
	terraform init

test:
	terraform fmt

