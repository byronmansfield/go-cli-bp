#!/bin/bash

# Original source before being modified: https://gist.github.com/pete-otaqui/4188238

# Works with a file called VERSION in the current directory,
# the contents of which should be a semantic version number
# such as "1.2.3"

# This script will display the current version, automatically
# suggest a "minor" version update, and ask for input to use
# the suggestion, or a newly entered value.

# Once the new version number is determined, the script will
# pull a list of changes from git history, prepend this to
# a file called CHANGELOG.md (under the title of the new version
# number) and create a GIT tag.

# Instalation:
# Add bumpversion.sh to you $HOME/bin folder
# Change permissions: chmod 755 bumpversion.sh
# Add $HOME/bin to your $PATH
# Symlink: cd $HOME/bin; ln -s bumpversion.sh bumpversion

# Ruby usage:
# change your metadata.rb file to use: IO.read(File.join(File.dirname(__FILE__), 'VERSION'))
# instead of the 3 digit number

if [ -f VERSION ]; then
    BASE_STRING=`cat VERSION`
    BASE_LIST=(`echo $BASE_STRING | tr '.' ' '`)
    V_MAJOR=${BASE_LIST[0]}
    V_MINOR=${BASE_LIST[1]}
    V_PATCH=${BASE_LIST[2]}
    echo "Current version : $BASE_STRING"
    V_MINOR=$((V_MINOR + 1))
    V_PATCH=0
    SUGGESTED_VERSION="$V_MAJOR.$V_MINOR.$V_PATCH"
    read -p "Enter a version number [$SUGGESTED_VERSION]: " INPUT_STRING
    if [ "$INPUT_STRING" = "" ]; then
        INPUT_STRING=$SUGGESTED_VERSION
    fi
    echo "Will set new version to be $INPUT_STRING"
    echo $INPUT_STRING > VERSION
    echo "Version $INPUT_STRING:" > tmpfile
    git log --pretty=format:" - %s" "v$BASE_STRING"...HEAD >> tmpfile
    echo "" >> tmpfile
    echo "" >> tmpfile
    cat CHANGELOG.md >> tmpfile
    mv tmpfile CHANGELOG.md
    git add CHANGELOG.md VERSION
    git commit -m "Version bump to $INPUT_STRING"
    git tag -a -m "Tagging version $INPUT_STRING" "v$INPUT_STRING"
    git push origin --tags
    git add --all
    git commit -m "Pushing uncommitted changes"
    git push --set-upstream origin `git rev-parse --abbrev-ref HEAD`
else
    echo "Could not find a VERSION file"
    read -p "Do you want to create a version file and start from scratch? [y]" RESPONSE
    if [ "$RESPONSE" = "" ]; then RESPONSE="y"; fi
    if [ "$RESPONSE" = "Y" ]; then RESPONSE="y"; fi
    if [ "$RESPONSE" = "Yes" ]; then RESPONSE="y"; fi
    if [ "$RESPONSE" = "yes" ]; then RESPONSE="y"; fi
    if [ "$RESPONSE" = "YES" ]; then RESPONSE="y"; fi
    if [ "$RESPONSE" = "y" ]; then
        echo "0.1.0" > VERSION
        echo "Version 0.1.0" > CHANGELOG.md
        git log --pretty=format:" - %s" >> CHANGELOG.md
        echo "" >> CHANGELOG.md
        echo "" >> CHANGELOG.md
        git add VERSION CHANGELOG.md
        git commit -m "Added VERSION and CHANGELOG.md files, Version bump to v0.1.0"
        git tag -a -m "Tagging version 0.1.0" "v0.1.0"
        git push origin --tags
        git add --all
        git commit -m "Pushing uncommitted changes"
        git push --set-upstream origin `git rev-parse --abbrev-ref HEAD`
    fi

fi
