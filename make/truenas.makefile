.PHONY: chart-release
chart-release:
	@rsync -av $(CHART)/helm/ charts/$(CHART)/$(shell cat $(CHART)/VERSION)/
