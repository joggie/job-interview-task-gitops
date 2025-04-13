# Makefile
SHELL := /bin/bash

# Set the environment file to source
ENV_FILE := .env

init-terraform:
	@terraform init

plan:
	@source $(ENV_FILE) && terraform plan -var-file=./tfvars/interview-gitops-sks.tfvars

apply:
	@source $(ENV_FILE) && terraform apply -var-file=./tfvars/interview-gitops-sks.tfvars

destroy:
	@source $(ENV_FILE) && terraform destroy -var-file=./tfvars/interview-gitops-sks.tfvars