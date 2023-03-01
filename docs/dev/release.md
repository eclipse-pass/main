# Overview

A PASS release produces a set of Java artifacts, and Docker images.
Java artifacts are pushed to Sonatype Nexus and Maven Central repositories. Docker images are pushed to GitHub Container Registry.
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
| Docker Compose | 2.x | 

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

### Release sequence

The Java projects must follow a strict sequence, following its dependency hierarchy. Other Javascript based projects can be released in any order. Both the Java and non-Java releases can be done in parallel, as there are no direct code dependencies between them.

1. [`main`](https://github.com/eclipse-pass/main)
2. Java projects
   1. [`pass-core`](https://github.com/eclipse-pass/pass-core)
   2. [`pass-support`](https://github.com/eclipse-pass/pass-support)
3. Non-Java projects
   * [`pass-ui`](https://github.com/eclipse-pass/pass-ui)
   * [`pass-auth`](https://github.com/eclipse-pass/pass-auth)
   * [`pass-acceptance-testing`](https://github.com/eclipse-pass/pass-acceptance-testing)
4. [`pass-docker`](https://github.com/eclipse-pass/pass-docker)


## Java release
The Maven release plugin is used to perform releases. It builds, tests, and pushes release artifacts. In addition it tags the release in the source and increments version numbers. Most of the Maven projects also use Maven to automatically build and push a Docker image. The release process is determined by the decision made to have versions for all Java artifacts be the same for a release. The parent pom in `main` sets the version to be inherited by all its children. This project therefore needs to be released first, as all other projects need to reference it. After this is released, other projects are released in an order which guarantees that all PASS dependencies for them have already been released.

The process itself can be described as follows: release `main`, then use the maven release and versions plugins to perform the process. For convenience we set and export environment variables RELEASE for the release version, and NEXT for the next development version (an example might be executing `export RELEASE=0.1.0` and `export NEXT=0.2.0-SNAPSHOT`)
For each of these child projects, we first clone the source from GitHub, and operating on the principal branch (usually `main`).

We would then update the parent version in these projects by:
```
mvn versions:update-parent;
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

Finally, the new development code needs to be pushed to GitHub. Since we are using the `main` pom to set versions, we need to have the new development version of `main` deployed to Sonatype before pushing the new development version of its children. once `mvn deploy -P release` has been run on main with the new development version set, it will be available in Sonatype for other projects to consume. The last step for these children is to update the parent version from the new snapshot version of `main` - so for each child, we do:

```
mvn versions:update-parent -DallowSnapshots=true
git push git@github.com:eclipse-pass/<PROJECT> main (or master)
mvn deploy -P release
```

At this point, we should have deployed the release to Sonatype (and eventually to Maven Central), pushed a tag to GitHub, and deployed the new development release to Sonatype.

In addition, the project may be released on GitHub. This provides a way to add release notes for a particular project. A GitHub release is done manually by uploading artifacts through the UI. The release version and tag should be the same used for Maven Central. Release notes can be automatically generated from commit messages and then customized.

----

See an example script that runs through these steps at [/tools/release.sh](/tools/release.sh)

### `main`

* Update POM version to release version
* Push update to GH
* Maven release
* Push release tag and update to new snapshot version to GH
* Maven deploy new snapshot

### `pass-core`

* Update POM version to release
* Push update to GH
* Maven release (include submodules)
* Push generated release Docker image to GHCR
* Push release tag to GH
* Update top level and submodule POMs, allowing SNAPSHOTS
* Push version updates on main to GH
* Maven deploy new snapshot
* Push snapshot Docker image to GHCR

This follows the same general release procedure as `main` with a few extra steps to account for submodules and Docker images

### `pass-support`

See procedure for `pass-core`, but without Docker images

## JavaScript projects

The following projects can be released by performing the following steps.

### `pass-ui`

Update the version in `package.json` and in `build.sh`, and commit those changes via a PR to the `pass-ui` repo.

Build a new docker image from within the `pass-ui` repo by running:
```
sh build.sh ~/pass-docker/.env
```
Note, you might want to ensure `node_modules` are removed first to ensure a clean build.

Push that image to ghcr.

### `pass-ui-public`
In `docker-compose.yml` in the `pass-docker` repo remove the sha from the image line, update the version tag at the end of the line to the version you are releasing.

Build a new docker image from within the root of the `pass-docker` repo by running:
```
docker compose build pass-ui-public
```
Push that image to ghcr.

### `pass-auth`
Update the version in `package.json`, and commit that change via a PR to the `pass-auth` repo.

Build a new docker image from within the `pass-auth`, for example by running:
```
docker build --no-cache -t ghcr.io/eclipse-pass/pass-auth:<your-version-tag>
```
Push that image to ghcr.

After pushing the images to ghcr, update the appropriate image lines in `docker-compose.yml` in `pass-docker` with the new sha's returned by the pushes to ghcr. Open a pull request against `pass-docker` with these updates.

Once acceptance-tests successfully run in CI in your `pass-docker` PR, and preferrably once you've done some additional manual spot checking while running `pass-docker` locally, go ahead and tag a new release in the Github UI. 

# Update pass-docker

Each released image must be updated in the `pass-docker` `docker compose.yml`. Each image is specified with a version and hash identifier. The versions should just be able to be updated to the new release version. The hash can be found using `docker inspect`.

### Building a single image

Updating a single image within [`pass-docker`](https://github.com/eclipse-pass/pass-docker) is largely done manually, for all images.

* Remove the `@sha256:...` from the end of the `image` property for the service. Update the image tag. 
	* Example: we want to update the current pass-core image to `0.3.0`: `ghcr.io/eclipse-pass/pass-core-main:0.2.0@sha256:56730754843aec0a3d48bfcefd13d72f1bb34708aea9b47d2280d2da61a1eb54` would be changed to `ghcr.io/eclipse-pass/pass-core-main:0.3.0`
* Build the image: `docker compose build <service-name>`
  For the fcrepo example above, you'd run `docker compose build pass-core`
* Push the new image: `docker compose push <service-name>`
  Example above: `docker compose push pass-core`
  This will return the hash that can be appended to the image property in the docker compose file to pin the version, since Docker image tags can be overwritten at any time

---

## docker compose rebuilding / updating
1. Remove the `@sha256` hash from the end of the image reference
2. Update the image tag to new tag
3. `docker compose build <service_name>`
4. `docker compose push <service_name>`: Copy the returned `sha256` hash
5. Append the copied hash to the image reference

## Retag without rebuild
* Grab the `image` reference from the docker compose file, *without the hash*. Ex: `ghcr.io/eclipse-pass/pass-core-main:0.2.0`
* `docker pull <image>:<tag>` - just makes sure you have the tag downloaded locally
* `docker tag <image>:<old_tag> <image>:<new_tag>` - creates the new tag
* `docker push <image>:<new_tag>` - pushes to your Docker repository. This will return a hash for the new tag
* You can now update the docker compose file with the new tag + hash

Example:
``` sh
docker pull ghcr.io/eclipse-pass/pass-core-main:0.2.0
docker tag ghcr.io/eclipse-pass/pass-core-main:0.2.0 ghcr.io/eclipse-pass/pass-core-main:0.3.0
docker push ghcr.io/eclipse-pass/pass-core-main:0.3.0
```

## Per-image customization

Here's what you need to change manually before building a new image version in order to bring in code changes. If the docker compose service is not mentioned here, you do not need to make any manual changes. All images must be built manually using docker compose, following the [docker compose rebuilding / updating](#docker compose-rebuilding--updating) steps except `pass-core` which is built by Maven.

#### `pass-ui`
In `.env`, by default, `EMBER_GIT_BRANCH` should have a value of `main`. If you need to point to a specific branch update the value of `EMBER_GIT_BRANCH`. You can use the name of a tag or a specific commit hash.

#### `pass-ui-public`
In `.env`, by default, `STATIC_HTML_BRANCH` should have a value of `main`. If you need to point to a specific branch update the value of `STATIC_HTML_BRANCH`. You can use the name of a tag or a specific commit hash.

#### `deposit`
TODO

#### `notification`
TODO

# Testing

Manual testing can be done using the newly updated pass-docker to run the release locally. Acceptance testing is run automatically on GitHub against pass-docker/main

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
