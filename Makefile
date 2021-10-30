SHELL := /bin/bash

IMAGE ?= $(shell cat IMAGE):$(shell cat VERSION)
IMAGE_LATEST ?= $(shell cat IMAGE):latest

.PHONY: buildx-context
buildx-context:
	docker buildx create --name arm64 --use --platform linux/amd64,linux/arm64,linux/arm/v8

.PHONY: build
build:
	@docker buildx build --platform linux/amd64,linux/arm64 . -t $(IMAGE)
	@docker buildx build --platform linux/amd64,linux/arm64 . -t $(IMAGE_LATEST) 

.PHONY: push
push:
	@docker push $(IMAGE)
	@docker push $(IMAGE_LATEST)
