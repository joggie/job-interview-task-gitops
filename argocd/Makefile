KUSTOMIZE_OVERLAYS_FOLDER ?= $(shell bash -c 'read -p "Enter Overlay Name: " message; echo $$message')

APPPROJECTS := $(shell ls -d components/appprojects/*/ | xargs -n 1 basename)

preview-bootstrap:
	kustomize build bootstrap/overlays/interview-gitops-sks

preview-cluster: index
	kustomize build clusters/interview-gitops-sks/bootstrap

index:
	find . -name 'createKustomizeFile.sh' -exec {} \;

install: index
	kustomize build bootstrap/overlays/interview-gitops-sks | kubectl apply -f -

project:
	@echo "Install / Upgrade project:"
	@i=1; \
	for project in $(APPPROJECTS); do \
		echo "$$i) $$project"; \
		i=$$(($$i + 1)); \
	done
	@echo "Please select a project by number:"
	@read PROJECTNUM; \
	PROJECTNAME=$$(echo $(APPPROJECTS) | cut -d' ' -f$$PROJECTNUM); \
	if [ -d "components/appprojects/$$PROJECTNAME" ]; then \
		kubectl apply -f components/appprojects/$$PROJECTNAME/appproject.yaml; \
	else \
		echo "Invalid selection."; \
	fi