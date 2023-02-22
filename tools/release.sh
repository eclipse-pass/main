#!/bin/sh

set -e

#=======================================================
# Setup
# 
# You need to have your Maven settings configured 
# correctly with Sonatype credentials and GPG signing
# passphrase
#=======================================================

# Alias mvn call to include several flags
#   -B batch mode
#   -U update SNAPSHOT dependencies
#   -V print Maven version (without halting build)
#   -ntp suppress (some) download log messages
#   -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener :: hide some more download log messages
alias maven="mvn -B -U -V -ntp -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn"

echo "${GHCR_PASSWORD}" docker login ghcr.io --username GHCR_USERNAME --password-stdin

# This assumes the following directory structure:
# working_dir
#   |- main/
#   |- pass-core/
#   \- pass-support/

# TODO: check for required env vars:
#   GHCR_PASSWORD
#   RELEASE (target release version, e.g. 0.3.0)
#   NEXT (target next dev version, e.g. 0.4.0-SNAPSHOT)
# if [[ -z "${GHCR_PASSWORD}" ]]; then
#   echo "GHCR_PASSWORD environment variable must be set"
#   exit 1
# fi
# if [[ -z "${RELEASE}" ]]; then
#   echo "RELEASE environment variable must be set"
#   exit 1
# fi
# if [[ -z "${NEXT}" ]]; then
#   echo "NEXT environment variable must be set"
#   exit 1
# fi

# TODO: Make sure we have local repos in place, and up-to-date

#=======================================================
# Release the main project POM
#=======================================================
cd ./main/

git checkout main

maven release:prepare \
  -DreleaseVersion=$RELEASE \
  -Dtag=$RELEASE \
  -DdevelopmentVersion=$NEXT
maven release:perform -P release

git push origin --tags # Will push the newly created release tag
git push origin main # Need to push `main` here to introduce new dev version

maven clean deploy -P release # Push new SNAPSHOT to Sonatype

#=======================================================
# Release pass-core
#=======================================================
cd ../pass-core/

git checkout main

# Update parent POM ref and commit
maven versions:update-parent -DparentVersion=$RELEASE

git add pom.xml **/pom.xml
git commit -m "Update parent version to latest release"

maven release:prepare \
  -DreleaseVersion=$RELEASE \
  -Dtag=$RELEASE \
  -DdevelopmentVersion=$NEXT \
  -DautoVersionSubmodules=true # _should_ update submodule POMs with correct versions
maven release:perform -P release

# Update parent and submodule versions
maven versions:update-parent -DallowSnapshots=true -DparentVersion=$NEXT

git push origin main
git push origin --tags

maven deploy -P release # Push new SNAPSHOT to Sonatype

# New Docker images will have been created during the release process
docker push ghcr.io/eclipse-pass/pass-core-main:$RELEASE
docker push ghcr.io/eclipse-pass/pass-core-main:$NEXT

#=======================================================
# Release pass-support
#=======================================================

cd ../pass-support/

git checkout main

maven versions:set -DnewVersion=$RELEASE
# Would update inter-project dependencies here, if applicable
# mvn versions:set -DnewVersion=$RELEASE -DartifactId=org.eclipse.pass:pass-core-main

git add pom.xml **/pom.xml
git commit -m "Update parent version to latest release"

maven release:prepare \
  -DreleaseVersion=$RELEASE \
  -Dtag=$RELEASE \
  -DdevelopmentVersion=$NEXT \
  -DautoVersionSubmodules=true
maven release:perform -P release

maven versions:set -DnewVersion=$NEXT -DallowSnapshots=true
# mvn versions:set -DnewVersion=$NEXT -DallowSnapshots=true -DartifactId=org.eclipse.pass:pass-core-main

git push origin main
git push origin --tags
