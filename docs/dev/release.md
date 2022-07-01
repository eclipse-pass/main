# Overview

A PASS release produces a set of Java artifacts, Node packages, and Docker images.
Java artifacts are pushed to Sonatype Nexus and Maven Central repositories. Docker images are pushed to DockerHub. Node packages are pushed to the NPM Registry.
The PASS Docker environment is updated with references to the released images.
Source code is tagged and release notes made available.

Each release of PASS has its own version which is used by every component. PASS uses `MAJOR.MINOR.PATCH` [semantic versioning](https://semver.org/) approach.
The version should be chosen based on those guidelines.

# Process

* Choose a release version that communicates the magnitude of the change.
* Order the projects to be released by their dependencies into a list such that each project only depend on projects earlier in the list.
* For each project in the list, do the release.
* Test the release
* Publish release notes

## Dependency ordering

Generally, dependencies are simple and the ordering can be figured out manually. Java project dependencies can be determined from their Maven pom. Every Java project depends on
the main PASS project pom. The Fedora repository image depends on pass-authz, pass-java-client, pass-fcrepo-jms, and pass-fcrepo-jsonld. Pretty much every Java component depends
on pass-java-client. The pass-package-providers library depends on pass-deposit-services. Then pass-deposit-services, pass-notification-services, and pass-package-providers
depend on pass-messaging-support.

A complication is the dependencies introduced by integration tests. Integration tests use Docker images to setup the testing environment and should use the images corresponding to
the current release. This introduces a new dependency on the image which introduces a dependency on the PASS component encapsulated by the image. This introduces some circular
dependencies between Java artifacts and Docker images. For example, the fcrepo image contains a servlet filter and user service from pass-authz, and pass-authz integration tests
use the fcrepo image. In order to get around this problem, integration tests could be run using older Docker images or integration testing could be skipped until after the Docker images in question are built.


Below is an attempt at the release order which ignores circular dependencies:

The main project pom, pass-java-client, pass-authz, pass-fcrepo-jms, pass-fcrepo-jsonld, fcrepo,  pass-indexer, pass-indexer-checker, pass-messaging-support, pass-doi-service, pass-download-service, pass-notification-services, pass-policy-service, pass-deposit-services, pass-grant-loader, pass-journal-loader, pass-nihms-loader, pass-metadata-schemas, pass-ember-adapter, pass-ui-public, pass-ui.

## Java release

The Maven release plugin is used to perform releases. It builds, tests, and pushes release artifacts. In addition it tags the release in the source and increments version numbers. Most of the Maven projects also use Maven to automatically build and push a Docker image.

Perform a release:
```
mvn release:prepare -DreleaseVersion=$RELEASE -Dtag=$RELEASE -DdevelopmentVersion=$NEXT 
mvn release:perform -Dgoals=deploy 
```

Push tags and version updates to GitHub:
```
git push git@github.com:eclipse-pass/<PROJECT> main
git push git@github.com:eclipse-pass/<PROJECT> --tags
```

Developers will need a Sonatype account to do the release. 

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

## Go

Set the Git tag to the release version.

Build and run integration tests:
```
docker-compose up -d
go test -tags=integration ./..
```

Tag and push the docker image
```
sh ./scripts/docker-push.sh;
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

Update docker.compose.yml to use newly built image and add hash to identifier. The hash can be found using docker inspect.

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

# Release notes







