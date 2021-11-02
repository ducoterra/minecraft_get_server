.PHONY: chart-release
chart-release:
	@rsync -av $(CHART)/helm/ charts/$(CHART)/$(shell cat $(CHART)/VERSION)/
	@git add charts/$(CHART)
	@git commit -m "Automated release for chart $(CHART) version $(shell cat $(CHART)/VERSION)" -e
