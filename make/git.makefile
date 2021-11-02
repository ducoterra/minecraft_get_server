.PHONY: git-release
git-release:
	@git add .
	@git commit -m "Automated release for version $(VERSION)"
	@git tag $(VERSION)
