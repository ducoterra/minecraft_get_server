SHELL := /bin/bash

PROJECT_NAME ?= $(shell git config --local remote.origin.url | sed -n 's\#.*/\([^.]*\)\.git\#\1\#p')
VERSION ?= $(shell cat VERSION)
IMAGE ?= $(shell cat IMAGE):$(VERSION)
IMAGE_LATEST ?= $(shell cat IMAGE):latest
PWD ?= $(shell pwd)

.PHONY: docker-init
docker-init:
	@touch VERSION
	@touch IMAGE

.PHONY: build
build:
	podman build . -t $(IMAGE)
	@podman build . -t $(IMAGE_LATEST)

.PHONY: push
push:
	podman build --platform linux/amd64,linux/arm64 --push . -t $(IMAGE)
	@podman build --platform linux/amd64,linux/arm64 --push . -t $(IMAGE_LATEST)
