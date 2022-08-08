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

### Building a single image

Updating a single image within [`pass-docker`](https://github.com/eclipse-pass/pass-docker) is largely done manually, for all images.

* Remove the `@sha256:...` from the end of the `image` property for the service. Update the image tag. 
	* Example: we want to update the current fcrepo image to `0.1.1`: `oapass/fcrepo:0.1.0@sha256:56730754843aec0a3d48bfcefd13d72f1bb34708aea9b47d2280d2da61a1eb54` would be changed to `oapass/fcrepo:0.1.1`
* Specific to the service in question, you may need to update either an environment variable in the `.env` file or update the Dockerfile, or both. We'll break down the changes on a per-image basis later.
* Build the image: `docker-compose build <service-name>`
  For the fcrepo example above, you'd run `docker-compose build fcrepo`
* Push the new image: `docker-compose push <service-name>`
  Example above: `docker-compose push fcrepo`
  This will return the hash that can be appended to the image property in the docker-compose file to pin the version, since Docker image tags can be overwritten at any time


### Sequencing

Image depdendency / usage diagram: https://www.figma.com/file/ibkDXjJ6AkXMpvPvL96gmi/Docker-Image-IT-dependencies?node-id=0%3A1

1. The following images can be created in this step in any order. In other words, they don't have any direct dependence on other image nor do they have any testing dependence. For example, most of our Java projects depend on the `fcrepo` image when running integration tests, so that image should be updated before verifying those code repositories when cutting releases.
   Once new images are built in this step, update their references in `eclipse-pass/main`. 
   * `activemq`
   * `assets`
   * `dspace`
   * `ember`
   * `fcrepo`
   * `ftpserver`
   * `proxy`
   * `idp`
   * `ldap`
   * `sp`
   * `mail`
   * `postgres`
   * `static-html`
2. The `indexer` should be updated next. ITs for this code repository only rely on `fcrepo`, but the built Docker image is used in nearly all other sets of integration tests.
   * The ITs for `indexer` run against a custom docker-compose environment, which must be updated manually
   * The `indexer` image should be updated in the `eclipse-pass/main` POM
3. The next set of project code ITs can be run to verify. All new images up to this point can be modified from the main POM and the versions will be inherited for tests:
	  * `eclipse-pass/pass-java-client`
	  * `eclipse-pass/pass-nihms-loader`
	  * `eclipse-pass/pass-journal-loader` - runs against custom docker-compose environment, must be updated manually
	  * `eclipse-pass/pass-grant-loader`
	  * `eclipse-pass/pass-notification-services`
	  * `eclipse-pass/pass-authz`
		  * Authz is a special case. Its ITs use `fcrepo` and `indexer` images. However, it wraps `fcrepo` in a custom built image where it injects its own updated artifacts. Sequencing the update of this repository is very tricky and may require some iteration of images
	  * `eclipse-pass/pass-doi-service`
	  * `eclipse-pass/pass-indexer-checker`
	* Golang projects run ITs against custom docker-compose files which will have to be updated manually:
	   * `eclipse-pass/pass-metadata-schemas`
	   * `eclipse-pass/pass-download-service`
	   * `eclipse-pass/pass-policy-service`
4. Publish a set of new images:  
   * `authz`
   * `notification`
   * `schemaservice`
   * `policyservice`
   * `doiservice`
   * `downloadservice`

Note that deposit services is missing from this list. This should be handled separately, as it takes some extra steps.

---

## docker-compose rebuilding / updating
1. Remove the `@sha256` hash from the end of the image reference
2. Update the image tag to new tag
3. `docker-compose build <service_name>`
4. `docker-compose push <service_name>`: Copy the returned `sha256` hash
5. Append the copied hash to the image reference

## Retag without rebuild
* Grab the `image` reference from the docker-compose file, *without the hash*. Ex: `oapass/docker-mailserver:20181105-1`
* `docker pull <image>:<tag>`
* `docker tag <image>:<old_tag> <image>:<new_tag>`
* `docker push <image>:<new_tag>`
* You can now update the docker-compose file with the new tag + hash

## Per-image customization

Here's what you need to change manually before building a new image version in order to bring in code changes. If the docker-compose service is not mentioned here, you shouldn't need to make any manual changes. All images must be built manually using docker-compose, following the [docker-compose rebuilding / updating](#docker-compose-rebuilding--updating) steps.

#### `fcrepo`
A new image is required if you there are code changes to: json-ld filters, jms-addons, authz core, (authz) user service, (authz) roles

1. Update Dockerfile: [`/fcrepo/4.7.5/Dockerfile`](https://github.com/eclipse-pass/pass-docker/blob/main/fcrepo/4.7.5/Dockerfile)
	* Update the JSON-LD servlet filter:
		* Maven Central: [Line 4](https://github.com/eclipse-pass/pass-docker/blob/main/fcrepo/4.7.5/Dockerfile#L4) (version number)
		* SNAPSHOT: [Line 73](https://github.com/eclipse-pass/pass-docker/blob/main/fcrepo/4.7.5/Dockerfile#L73-L74) (artifact download URL) && [Line 75](https://github.com/eclipse-pass/pass-docker/blob/main/fcrepo/4.7.5/Dockerfile#L75) (associated SHA1 hash)
	* JMS addons:
		* Maven Central: [Line 6](https://github.com/eclipse-pass/pass-docker/blob/main/fcrepo/4.7.5/Dockerfile#L6) (version number)
		* SNAPSHOT: [Line 95](https://github.com/eclipse-pass/pass-docker/blob/main/fcrepo/4.7.5/Dockerfile#L95-L96) (artifact download URL) && [Line 97](https://github.com/eclipse-pass/pass-docker/blob/main/fcrepo/4.7.5/Dockerfile#L97) (associated SHA1 hash)
	* Update Authz codebase - `pass-authz-core`,  `pass-user-service`, and `pass-authz-roles` must have the same version number, as they are published from the same project
		* Maven Central: [Line 5](https://github.com/eclipse-pass/pass-docker/blob/main/fcrepo/4.7.5/Dockerfile#L5) (release version number)
		* SNAPSHOT:
			* Authz core: [Line 77](https://github.com/eclipse-pass/pass-docker/blob/main/fcrepo/4.7.5/Dockerfile#L77-L78) (shaded JAR URL) && [Line 79](https://github.com/eclipse-pass/pass-docker/blob/main/fcrepo/4.7.5/Dockerfile#L79) (sha1 hash)
			* Authz roles: [Line 81](https://github.com/eclipse-pass/pass-docker/blob/main/fcrepo/4.7.5/Dockerfile#L81-L82) (JAR URL) && [Line 83](https://github.com/eclipse-pass/pass-docker/blob/main/fcrepo/4.7.5/Dockerfile#L83) (sha1 hash)
			* User service: [Line 86](https://github.com/eclipse-pass/pass-docker/blob/main/fcrepo/4.7.5/Dockerfile#L85-L86) (WAR URL) && [Line 87](https://github.com/eclipse-pass/pass-docker/blob/main/fcrepo/4.7.5/Dockerfile#L87) (sha1 hash)

2. [Building a single image](#Building-a-single-image): [Line 8](https://github.com/eclipse-pass/pass-docker/blob/main/docker-compose.yml#L8)

#### `activemq`
Should only need to be updated if updating the ActiveMQ version, which is only referenced as an [environment variable in the Dockerfile](https://github.com/eclipse-pass/pass-docker/blob/main/activemq/Dockerfile#L3).

#### `ember`
In `.env`, update the value of `EMBER_GIT_BRANCH`. You can use the name of a tag or a specific commit hash here

#### `static-html`
In `.env` update the `STATIC_HTML_BRANCH` value. You can use a tag or commit hash

#### `ftpserver`
Shouldn't need to update, as this is intended to be only used during integration tests. Can re-tag the image by either rebuilding from the [Dockerfile](https://github.com/eclipse-pass/pass-docker/blob/main/ftpserver/Dockerfile) or [Retag without rebuild](#retag-without-rebuild)

#### `indexer`
* Update the `PI_VERSION` var in the Dockerfile
* Update [artifact URL](https://github.com/eclipse-pass/pass-docker/blob/main/indexer/Dockerfile#L14)
* Update [sha1 hash](https://github.com/eclipse-pass/pass-docker/blob/main/indexer/Dockerfile#L15)
* If necessary, update the `ESCONFIG_VERSION` var in the Dockerfile.

#### `assets`
??

#### `deposit`
[Handling Deposit Services](Handling-Deposit-Services)

#### `authz`
For new Authz code release:

* Update[ `VERSION` var](https://github.com/eclipse-pass/pass-docker/blob/main/authz/Dockerfile#L2)
* Update sha1 hash of the [`pass-authz-listener-<version>-exe.jar`](https://github.com/eclipse-pass/pass-docker/blob/main/authz/Dockerfile#L15)

#### `mail`
??

#### `notification`
* Update [`NOTIFICATION_SERVICE_VERSION` var](https://github.com/eclipse-pass/pass-docker/blob/main/notification-services/0.1.0-3.4/Dockerfile#L3)
* Update [`JSONLD_CONTEXT_VERSION`](https://github.com/eclipse-pass/pass-docker/blob/main/notification-services/0.1.0-3.4/Dockerfile#L4) if necessary
* Update [artifact URL](https://github.com/eclipse-pass/pass-docker/blob/main/notification-services/0.1.0-3.4/Dockerfile#L24)

# Testing

Manual testing can be done using the newly updated pass-docker to run the release locally.

# Post Release

  * [Update release notes](#update-release-notes)
  * Update project documentation
  * Deploying the release


### Update release notes

1. Create a new label in GitHub issues by going to https://github.com/eclipse-pass/main/labels, selecting "New Label" and naming it "Release X.X.X" (using the new release number).
2. Get a list of all issues that are closed and in the eclipse-pass project by going to: https://github.com/eclipse-pass/main/issues?page=1&q=is%3Aissue+is%3Aclosed+project%3Aeclipse-pass%2F4
3. Apply the new label by selecting all, selecting the "Label" dropdown, and choosing the release label. If there are multiple pages of tickets, you'll need to do this on each page.
4. Archive the release tickets in the Project by going to the Kanban Board https://github.com/orgs/eclipse-pass/projects/4/views/2, scrolling to the Done column, verifying that all tickets in the list have the new version tag, then selecting the ellipsis button and "Archive all cards"
5. Include in the Release Notes a link to the issues resolved by the release, e.g. https://github.com/eclipse-pass/main/issues?q=label%3A%22Release+0.1.0%22
