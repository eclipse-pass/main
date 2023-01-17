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
| Java | 11 |
| Maven | 3.8.x |
| Docker | 20.10.x |
| Docker Compose | 1.29.2 | 

## Sonatype

Developers will need a Sonatype account to release Java projects.
Maven must be configured to use the account by modifying your ~/.m2/settings.xml. Documentation for Sonatype publishing
is available here: https://central.sonatype.org/publish/publish-guide/

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
## GitHub Container Registry (GHCR)

Developers will need a GitHub account which is a member of the [eclipse-pass](https://github.com/eclipse-pass) organization. 

# Process

* Choose a release version that communicates the magnitude of the change.
* Order the projects to be released by their dependencies into a list such that each project only depend on projects earlier in the list.
* For each project in the list, do the release.
* Update images in pass-docker
* Test the release
* Publish release notes

A new release for each relevant project should be created in the GitHub user interface until automation is put in place.

The release notes are generated automatically by GitHub, but references to the release artifacts should be added manually.
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


In addition, the project may be released on GitHub. This provides a way to add release notes for a particular project. A GitHub release is done manually by uploading artifacts through the UI. The release version and tag should be the same used for Maven Central. Release notes can be automatically generated from commit messages and then customized.

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

#### `activemq`
Should only need to be updated if updating the ActiveMQ version, which is only referenced as an [environment variable in the Dockerfile](https://github.com/eclipse-pass/pass-docker/blob/main/activemq/Dockerfile#L3).

#### `ember`
In `.env`, update the value of `EMBER_GIT_BRANCH`. You can use the name of a tag or a specific commit hash here

#### `static-html`
In `.env` update the `STATIC_HTML_BRANCH` value. You can use a tag or commit hash

#### `deposit`
TODO

#### `notification`
TODO

# Testing

Manual testing can be done using the newly updated pass-docker to run the release locally. Acceptance testing is run automatically on GitHub
against pass-docker/main

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
