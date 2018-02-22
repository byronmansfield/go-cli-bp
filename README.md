# Golang cli tool boilerplate Repo

A Golang Command Line Tool Boilerplate repo. This is designed to help you quickly get up and running making a command line tool app in Golang without having to manually set it up each time. You should be able to clone this repo and follow the initial set up instructions and then start writing you app.

There are likely more things included than needed. This is just so you have them available. Delete what you don't want or won't use.

## Usage

Basic idea/workflow.

### Start a new project and initialize it

#### Clone project and cd into it

```bash
cd $GOPATH/src/github.com/<myuser>
git clone git@github.com:byronmansfield/go-cli-bp.git myApp
cd myApp
```

#### Initialize and Setup the project

First open up the `Makefile` and change the project name. It should be the variable at the top of the `Makefile` called `APPNAME`. This will create a top level directory with this name where all of your commands will live. It will also be the name of the executable that will be your command line tool.

Once you have made this change, save the file, exit, and run

```bash
make setup
```

You should have a working command line app. It won't do much yet, but you should everything set up you need in order to start writing it.

### Suggested first steps

You may want to make some initial changes like the maintainers name and email at the top of the `main.go` file, the `LICENSE` file, the `CONTRIBUTING.md` doc, or the `README.md`

You probably want to tell `git` where the project lives so you can push your changes

```bash
git remote add origin https://github.com/user/repo.git
```

You also probably want to familiarize your self with the tools used in this project, so that you can write your application in a manor that flows with their patterns.

 - [Cobra](https://github.com/spf13/cobra]) is the framework, their [official go docs are here](https://godoc.org/github.com/spf13/cobra), and official page is [here](http://spf13.com/post/announcing-cobra/).
 - [goreleaser](https://goreleaser.com/) is the releasing tool
 - [dep](https://golang.github.io/dep/) is the dependency management tool

It is probably also wise to familiarize yourself with the `Makefile` to customize the targets for your needs.

## Included Tools

The tools included in this boilerplate project are:

 - [editorconfig](http://editorconfig.org/)
 - gitignore - this is mostly copy and pasted from [gitignore.io](https://www.gitignore.io/) for most of the tools I can think of that would be needed for most Golang cli projects, including editors and OS's
 - dockerignore - This includes most of the platforma, documentations, dependency managment, vim swp files, and other common tools for Golang cli projects
 - Dockerfile
 - Makefile
 - Contributing document
 - MIT License
 - Readme
 - [dep](https://golang.github.io/dep/) - For dependency management of go packages
 - [goreleaser](https://goreleaser.com/) - To release the project with official github release support
 - [Cobra](https://github.com/spf13/cobra) - Command Line Framework
 - Custom version bumping script for official releases

## Closing

That's it for now. Now go make some cli tools!

