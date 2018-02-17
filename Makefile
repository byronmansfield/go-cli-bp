#
# What I want for targets
#

make - done

make install - done

make clean

make distclean

make release

make build - done

make setup - done


MYOS := $(shell uname)
BUILD_DATE ?= $(strip $(shell date -u +"%Y-%m-%dT%H:%M:%SZ"))
VERSION ?= $(shell cat VERSION)
VENDOR ?= bmansfield
PROJECT_NAME ?= golang-cli-bp
DOCKER_IMAGE ?= $(VENDOR)/$(PROJECT_NAME)
PLATFORMS := linux/amd64 windows/amd64
GIT_TAG ?= $(strip $(shell git rev-parse --abbrev-ref HEAD | tr '/' '-'))
GIT_URL ?= $(strip $(shell git config --get remote.origin.url))

# Find out if the working directory is clean
GIT_NOT_CLEAN_CHECK = $(shell git status --porcelain)

temp = $(subst /, ,$@)
os = $(word 1, $(temp))
arch = $(word 2, $(temp))

default: build

release: $(PLATFORMS)

build: go_build

install: go_install

setup: dep_init

release: go_release

# Get the version number from the code
GIT_TAG = v$(strip $(shell cat GIT_TAG))

ifndef GIT_TAG
$(error You need to create a GIT_TAG file to deploy)
endif

$(PLATFORMS):
	GOOS=$(os) GOARCH=$(arch) go build -o '$(os)-$(arch)' mypackage

go_build:
	go build -o mypackage

go_install:
	go install

dep_init:
	dep init

git_tag:
	bumpversion
	git tag -a $(GIT_TAG) -m "First release"
	git push origin $(GIT_TAG)

go_release:
	git_tag goreleaser

.PHONY release $(PLATFORMS)
