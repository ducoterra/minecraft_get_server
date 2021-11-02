SHELL := /bin/bash

PROJECT_NAME ?= $(shell git config --local remote.origin.url | sed -n 's\#.*/\([^.]*\)\.git\#\1\#p')
VERSION ?= $(shell cat VERSION)
IMAGE ?= $(shell cat IMAGE):$(VERSION)
IMAGE_LATEST ?= $(shell cat IMAGE):latest
PWD ?= $(shell pwd)
STASH ?= "common-update-stash"

include .gitlab/make/docker.makefile
include .gitlab/make/helm.makefile
include .gitlab/make/kaniko.makefile
include .gitlab/make/truenas.makefile
include .gitlab/make/git.makefile

.PHONY: make-update
make-update:
	@git subtree pull --prefix .gitlab --squash --message "Merge update from Common" -q git@gitlab.ducoterra.net:services/common.git main
