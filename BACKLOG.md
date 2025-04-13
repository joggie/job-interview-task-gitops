##### Add additional environments. We may have test, staging and prod. But it could happen that we may need some kind of dynamic approach as we require to setup a short living environment for potential customers in the future for demo reasons.

DONE: ArgoCD is set up to support multiple clusters. Just clone argocd/bootstrap/overlays/interview-gitops-sks and argocd/clusters/interview-gitops-sks to spin up a new one with the same or a custom config
DONE: Terraform supports per-environment configs via terraform/tfvars

##### Get rid of writing export TF_VAR_<something> every time.

DONE: Added a .env file for Terraform. Also added a Makefile, just run make init, make plan, and make apply
Alternatively, shell plugins can auto-load the .env file

##### Check how to structure the code in a better way.

DONE: Refactored Terraform into a cleaner modular setup
DONE: ArgoCD is also now modular and works with multiple clusters

##### Run the code in a pipeline. If we have some changes I would like to run it for the related environment. Something like PR based approach with approval would be a nice thing.

IDEAS:
Protect the master branch so only a specific user group can approve and merge pull requests.
That way, changes go through review before landing in production.

##### Creating the loadbalancer by using kubernetes service type LoadBalancer seems not to be the ideal solution for us. Or there is a way to preserve the IP if we recreate it.

IDEAS:
On Exoscale, preserving the IP of a LoadBalancer is not straightforward. If the service is deleted, the Exoscale Loadbalancer goes with it.

Possible workarounds:
 - Manually create the LB on Exoscale and link it to Kubernetes using metadata annotations
 - Use MetalLB and assign it an elastic IP

##### Reduce time of adjusting terraform code. Some plugin or whatever for autoformat like in PHPStorm would be nice. Need to investigate.

IDEAS:
Use the Terraform extension in VSCode
Also, run "terraform fmt" to auto-format the code on save or in CI

##### As we will get more and more apps up and runnig, we need to think about the deployment structure. Maybe something like app of apps. Maybe there is something better.

DONE: app of apps pattern is already in place and working

##### Our domain is currently managed by these devops guys. But I need to include it into terraform so I can set the IP record. Need to discuss this with them.

IDEAS:
Figure out the current DNS provider and use its Terraform provider to manage records

##### Enable SSL on ingress with valid certificate. We can go with let's encrypt here.

DONE: Cert-manager is installed, issuing Let’s Encrypt certs

##### Try to deploy app with kustomize instead of helm. Will need to look into some best practices. I would like to have some kind of config repo where we can set only really required configs and some kind of deployment definition repo where to which we can reference the revision. And what about if we have even more of these values.yamls?

DONE: Cluster config with ArgoCD now uses Kustomize. Base + overlay model is in place for clean separation

##### Secret management is a topic!

IDEAS:
Set up HashiCorp Vault with Vault Secrets Operator and Auto-Unsealer for handling secrets securely