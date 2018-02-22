#!/bin/bash

_cancel() {
  echo "No version file created"
  echo "Exiting"
  exit 1
}

_invalid_input() {
  echo "Invalid response"
  echo "Please retry the script with a different response"
  echo "Exiting"
  exit 1
}

_init() {
  echo "Could not find a VERSION file"
  read -r -p "Do you want to create a version file and start from scratch? [Y/n]" response

  case ${response} in
    [yY][eE][sS]|[yY]|"")
      _create_version
      ;;
    [nN][oO]|[nN])
      _cancel
      ;;
    *)
      _invalid_input
      ;;
  esac
}

_create_version() {

  echo "Versioning project"

  echo "0.1.0" > VERSION

  git add VERSION
  git commit -m "Added VERSION file, Version bump to v0.1.0"
  git tag -a -m "Tagging version 0.1.0" "v0.1.0"
  git push origin --tags
  git add --all
  git commit -m "Pushing uncommitted changes"
  git push --set-upstream origin `git rev-parse --abbrev-ref HEAD`
}

_bump_version() {

  VERSION=`cat VERSION`
  VERSION_DETAILS=(`echo ${VESION} | tr '.' ' '`)
  MAJOR=${VERSION_DETAILS[0]}
  MINOR=${VERSION_DETAILS[1]}
  PATCH=${VERSION_DETAILS[2]}

  echo "Current version : ${VERSION}"

  MINOR=$((MINOR + 1))
  PATCH=0
  SUGGESTED_VERSION="${MAJOR}.${MINOR}.${PATCH}"

  read -r -p "Enter a version number. Suggested version [${SUGGESTED_VERSION}]: " response

  if [ -z "${response}"]; then
    ${response}=${SUGGESTED_VERSION}
  fi

  echo "Will set new version to be ${response}"
  echo "${response}" > VERSION
  echo "Version ${response}:" > tmpfile

  git log --pretty=format:" - %s" "v$VERSION"...HEAD >> tmpfile
  echo "" >> tmpfile
  echo "" >> tmpfile
  cat CHANGELOG.md >> tmpfile
  mv tmpfile CHANGELOG.md

  git add CHANGELOG.md VERSION
  git commit -m "Version bump to ${response}"
  git tag -a -m "Tagging version ${response}" "v${response}"
  git push origin --tags
  git add --all
  git commit -m "Pushing uncommitted changes"
  git push --set-upstream origin `git rev-parse --abbrev-ref HEAD`
}

main() {

  if [ -f VERSION ]; then
    _bump_version
  else
    _init
  fi

}

main

