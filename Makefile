APPNAME := cli-app
MYOS := $(shell uname)
BUILD_DATE ?= $(strip $(shell date -u +"%Y-%m-%dT%H:%M:%SZ"))
VERSION ?= $(shell cat VERSION)
VENDOR ?= bmansfield
PROJECT_NAME ?= go-cli-bp
DOCKER_IMAGE ?= $(VENDOR)/$(PROJECT_NAME)
GIT_TAG ?= $(strip $(shell git rev-parse --abbrev-ref HEAD | tr '/' '-'))
GIT_URL ?= $(strip $(shell git config --get remote.origin.url))

# Find out if the working directory is clean
GIT_NOT_CLEAN_CHECK = $(shell git status --porcelain)

default: build

build: go_build

install: go_install

setup: dep_init

release: go_release

# Get the version number from the code
GIT_TAG = v$(strip $(shell cat GIT_TAG))

ifndef GIT_TAG
$(error You need to create a GIT_TAG file to deploy)
endif

go_build:
	go build -o mypackage

go_install:
	go install

dep_init:
	go get -u github.com/spf13/cobra/cobra
	go get github.com/goreleaser/goreleaser
	go get -u github.com/golang/dep/cmd/dep
	mkdir -p $(APPNAME)
	cobra init ./$(APPNAME)
	dep init

git_tag:
	./script/bump.sh
	git tag -a $(GIT_TAG) -m "First release"
	git push origin $(GIT_TAG)

go_release:
	git_tag goreleaser

.PHONY release setup install build go_build go_install dep_init git_tag go_release
