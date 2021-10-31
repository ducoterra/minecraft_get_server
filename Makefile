SHELL := /bin/bash

IMAGE ?= $(shell cat IMAGE):$(shell cat VERSION)
IMAGE_LATEST ?= $(shell cat IMAGE):latest
PWD ?= $(shell pwd)

.PHONY: buildx-context
buildx-context:
	docker buildx create --name arm64 --use --platform linux/amd64,linux/arm64

.PHONY: buildx-clear
buildx-clear:
	docker buildx rm arm64

.PHONY: build
build:
	docker buildx build --load . -t $(IMAGE)
	@docker buildx build --load . -t $(IMAGE_LATEST) 

.PHONY: push
push:
	docker buildx build --platform linux/amd64 --push . -t $(IMAGE)
	@docker buildx build --platform linux/amd64 --push . -t $(IMAGE_LATEST)

.PHONY: run
run:
	docker run -it -v $(PWD):/mc_data $(IMAGE) bash
