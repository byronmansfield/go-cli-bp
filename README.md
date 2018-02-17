# Golang cli tool boilerplate Repo

A simple repo to store some common new repo setup config files for writing a new Golang cli tool. I started this repository to have a solution to initializing new git projects. I'm lazy, and hate trying to keep track or all these things or forget to add something, etc. Most of these boilerplate files will have a full list of things that will more than likely not be needed by most projects. It's just easier to delete what you don't need, rather than search around for the things (over and over) that you need but don't bother to computer to memory.

## Usage

Basic idea/workflow.

### Start a new project

```bash
cd $GOPATH/src/github.com/<myuser>
git clone git@github.com:byronmansfield/go-cli-bp.git myapp
cd myapp
```

#### Initialize new blank cli app

I don't have a solution to this yet. I need to go back and add this once I figure out which path I want to take for doing this step.

One idea is to have a go package you would simple `go get` and install, then say `go-bp init`.

Another idea is to have `make` do it from a target in the `Makefile`

Another idea is to have a bash script for the setup. Which could overlap with the `make` idea

The final idea would be to have a `docker` container do this for you. Then you would just have to follow up with `git clone`

## Tools

The tools included in this boilerplate project are

 - editorconfig
 - gitignore - this is mostly copy and pasted from gitignore.io for most of the tools I can think of that would be needed for most Golang cli projects, including editors and OS's
 - dockerignore - This includes most of the platforma, documentations, dependency managment, vim swp files, and other common tools for Golang cli projects
 - Dockerfile
 - Makefile
 - Contributing mark down file
 - License
 - Readme mark down
 - golang/dep
 - goreleaser
 - cobra

## Summary

That's it for now. Have fun!
