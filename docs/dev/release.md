# Overview

A PASS release produces a set of Java artifacts, Node packages, and Docker images.
Java artifacts are pushed to Sonatype Nexus and Maven Central repositories. Docker images are pushed to DockerHub. Node packages are pushed to the NPM Registry.
The PASS Docker environment is updated with references to the released images.
Source code is tagged and release notes made available.

Each release of PASS has its own version which is used by every component. PASS uses `MAJOR.MINOR.PATCH` [semantic versioning](https://semver.org/) approach.
The version should be chosen based on those guidelines.

# Community preparation

  * Assign a Release Manager, the person who will be responsible for the release process. The Release Manager must be a PASS committer.
  * Ensure all code commits and PRs intended for the release have been merged.
  * Issue a code freeze statement on the Eclipse PASS slack #general channel to notify all developers that a release is imminent and that no further changes will be considered.

# Release requirements

Make sure the following software is installed:

|Name | Version |
| --- | --- |
| Go  | 1.12 |
| Java | 11 |
| Node | 14.x | 
| Npm | 6.14.x |
| Maven | 3.8.x |
| Docker | 20.10.x |
| Docker Compose | 1.29.2 | 

## Sonatype

Developers will need a Sonatype account to release Java projects.
Maven must be configured to use the account by modifying your ~/.m2/settings.xml.

```
<settings>
  <servers>
    <server>
      <id>ossrh</id>
      <username>YOUR_SONATYPE_USERNAME</username
      <password>YOUR_SONATYPE_PASSWORD</password>
    </server>
  </servers>
  <profiles>
    <profile>
      <id>ossrh</id>
      <activation>
        <activeByDefault>true</activeByDefault>
      </activation>
      <properties>
        <gpg.executable>gpg</gpg.executable>
        <gpg.passphrase>YOUR_GPG_PASSPHRASE</gpg.passphrase>
      </properties>
    </profile>
  </profiles>
</settings>

```

## Docker Hub

Developers will need a Docker Hub account which is a member of the the oapass organization.

## NPM

Developers will need an NPM account with access to any Node packages being published. At the moment, this is only ember-fedora-adapter (pass-ember-adapter).

# Process

* Choose a release version that communicates the magnitude of the change.
* Order the projects to be released by their dependencies into a list such that each project only depend on projects earlier in the list.
* For each project in the list, do the release.
* Update images in pass-docker
* Test the release
* Publish release notes

## Dependency ordering

Generally, dependencies are simple and the ordering can be figured out manually. Java project dependencies can be determined from their Maven pom. Every Java project depends on
the main PASS project pom. The Fedora repository image depends on pass-authz, pass-java-client, pass-fcrepo-jms, and pass-fcrepo-jsonld. Pretty much every Java component depends
on pass-java-client. The pass-package-providers library depends on pass-deposit-services. Then pass-deposit-services, pass-notification-services, and pass-package-providers
depend on pass-messaging-support.

A complication is the dependencies introduced by integration tests. Integration tests use Docker images to setup the testing environment. The images should be from the release being built. This introduces a new dependency on the image in turn adds dependency on the PASS component encapsulated by the image. Unfortunately this can cause circular
dependencies between Java artifacts and Docker images. For example, the fcrepo image contains a servlet filter and user service from pass-authz, and pass-authz integration tests
use the fcrepo image. In order to get around this problem, integration tests could be run using older Docker images or integration testing could be skipped until after the Docker images in question are built. The integration test dependencies could be better accounted for by adding them explicitly as test dependencies to the poms.

Below is an attempt at the release order which ignores circular dependencies:

The main project pom, pass-java-client, pass-authz, pass-fcrepo-jms, pass-fcrepo-jsonld, fcrepo,  pass-indexer, pass-indexer-checker, pass-messaging-support, pass-doi-service, pass-download-service, pass-notification-services, pass-policy-service, pass-deposit-services, pass-grant-loader, pass-journal-loader, pass-nihms-loader, pass-metadata-schemas, pass-ember-adapter, pass-ui-public, pass-ui.

## Java release
The Maven release plugin is used to perform releases. It builds, tests, and pushes release artifacts. In addition it tags the release in the source and increments version numbers. Most of the Maven projects also use Maven to automatically build and push a Docker image.
The release process is determined by the decision made to have versions for all Java artifacts be the same for a release. The parent pom in `main` sets the version to be inherited by all its children.
This project therefore needs to be released first, as all other projects need to reference it.
After this is released, other projects are released in an order which guarantees that all PASS dependencies for them have already been released.

The process itself can be described as follows: release `main`, then use the maven release and versions plugins to perform the
process. For convenience we set and export environment variables RELEASE for the release version, and NEXT for the next development version (an example might be executing `export RELEASE=0.1.0` and `export NEXT=0.2.0-SNAPSHOT`)
For each of these child projects, we first clone the source from GitHub, and operating on the principal branch (usually `main`, sometimes `master` for older projects).
We would then update the parent version in these projects by:
```
mvn:versions  update-parent;
git commit -a -m "update parent version for release";
```
After this, we prepare and perform the release:

```
mvn release:prepare -DreleaseVersion=$RELEASE -Dtag=$RELEASE -DdevelopmentVersion=$NEXT 
mvn release:perform -Dgoals=deploy 
```

If integration tests need to be skipped, `-DskipITs=true` can be added to the commands above.

Push tags to GitHub:
```
git push git@github.com:eclipse-pass/<PROJECT> --tags
```

Finally, the new development code needs to be pushed to GitHub. Since we are using the `main` pom to set versions, we need to have the new development version of `main`
deployed to Sonatype before pushing the new development version of its children. once `mvn deploy -P release` has been run on main with the new development version set,
it will be available in Sonatype for other projects to consume. The last step for these children is to update the
parent version from the new snapshot version of `main` - so for each child, we do

```
mvn versions:update-parent -DallowSnapshots=true
git push git@github.com:eclipse-pass/<PROJECT> main (or master)
mvn deploy -P release

```

At this point, we should have deployed the release to Sonatype (and eventually to Maven Central), pushed a tag to GitHub, and deployed the new development release to Sonatype.


In addition, the project may also be released on GitHub. This provides a way to add release notes for a particular project. A GitHub release is done manually by uploading artifacts through the UI. The release version and tag should be the same used for Maven Central. Release notes can be automatically generated from commit messages and then customized.

## Go

Set the Git tag to the release version.

Build and run integration tests:
```
docker-compose up -d
go test -tags=integration ./..
```

Tag and push the docker image
```
sh ./scripts/docker-push.sh
```

## Docker image release

The only images which have to built manually are fcrepo and pass-indexer.

In pass-docker edit docker-compose.yml such that the image in question has the release version.

Build the image:
```
docker-compose build IMAGE_NAME
```

Push the image:
```
docker push IMAGE_NAME:VERSION
```

## Node package release

Edit package.json to set the version to the release version.

Build:
```
npm install
npm build
```

Publish to the NPM registry:

```
npm publish
```

# Update pass-docker

Each released image must be updated in the `pass-docker` `docker-compose.yml`. Each image is specified with a version and hash identifier. The versions should just be able to be updated to the new release version. The hash can be found using `docker inspect`.

# Testing

Manual testing can be done using the newly updated pass-docker to run the release locally.

# Post Release

  * Update release notes
  * Update project documentation
  * Deploying the release