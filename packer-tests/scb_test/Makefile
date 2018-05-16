all: plan apply

clean:
	rm -rf .terraform

plan:
	terraform plan -no-color -var-file=secrets.tfvars -var-file=terraform.tfvars

destroy:
	terraform destroy -no-color -force -var-file=secrets.tfvars -var-file=terraform.tfvars

apply:
	terraform apply -no-color -var-file=secrets.tfvars -var-file=terraform.tfvars

init:
	terraform init

test:
	terraform fmt

