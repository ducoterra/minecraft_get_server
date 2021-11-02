.PHONY: helm-release
helm-release:
	@yq e ".version = \"$(shell cat VERSION)\"" -i helm/Chart.yaml	
	@yq e ".appVersion = \"$(shell cat VERSION)\"" -i helm/Chart.yaml
