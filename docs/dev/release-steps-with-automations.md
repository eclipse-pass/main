# Project release sequence

Actions listed below are to be done by the release manager.

## Release All Projects

The [Publish: Release All](/.github/workflows/pass-complete-release.yml) is a GitHub workflow that will release all the PASS projects in the correct order, build and push docker images, and create GitHub Releases.
The `Publish: Release All` requires GitHub PAT configuration.  See [GitHub Personal Access Token Setup](#github-personal-access-token-setup).

The `Publish: Release All` workflow is the preferred method of doing a PASS release.  If for some reason, a PASS release needs to be done one project at a time, follow the steps in [Release Projects One At a Time](#release-projects-one-at-a-time) section.


## Release Projects One At a Time



### Java projects
The [Publish: release all Java modules](https://github.com/eclipse-pass/main/actions/workflows/pass-java-release.yml) combines all the Java projects together and then releases them in one single workflow.
The `Publish: release all Java modules` requires GitHub PAT configuration.  See [GitHub Personal Access Token Setup](#github-personal-access-token-setup).

If needed, the individual java components can be released individually. Release these in the order defined here due to 
dependencies. Between each of these releases, you will need to wait for the Java artifacts to appear on Maven Central. 
This will give you enough time to do other release activities, such as releasing non-Java artifacts. The release 
workflows should wait for you, but is good to check anyway.

1. [`main`](https://github.com/eclipse-pass/main)
   * [Release workflow](https://github.com/eclipse-pass/main/actions/workflows/release.yml)
   * [Maven central](https://central.sonatype.com/artifact/org.eclipse.pass/eclipse-pass-parent)
2. [`pass-core`](https://github.com/eclipse-pass/pass-core)
   * [Release workflow](https://github.com/eclipse-pass/pass-core/actions/workflows/release.yml)
   * [Maven Central](https://central.sonatype.com/artifact/org.eclipse.pass/pass-core-main/0.4.0)
   * [Package](https://github.com/eclipse-pass/pass-core/pkgs/container/pass-core-main)
3. [`pass-support`](https://github.com/eclipse-pass/pass-support)
   * [Release workflow](https://github.com/eclipse-pass/pass-support/actions/workflows/release.yml)
   * [Maven Central](https://central.sonatype.com/artifact/org.eclipse.pass/pass-support)
   * https://github.com/eclipse-pass/pass-support/pkgs/container/pass-notification-service
   * https://github.com/orgs/eclipse-pass/packages/container/package/jhu-grant-loader
   * https://github.com/orgs/eclipse-pass/packages/container/package/deposit-services-core
   * https://github.com/orgs/eclipse-pass/packages/container/package/pass-journal-loader
   * https://github.com/orgs/eclipse-pass/packages/container/package/pass-nihms-loader


### Non-Java projects
These can be released in any order. You should release these between releasing Java components, while waiting for artifacts to become available in Maven Central.

* [`pass-ui`](https://github.com/eclipse-pass/pass-ui)
  * [Release workflow](https://github.com/eclipse-pass/pass-ui/actions/workflows/release.yml)
  * [Package](https://github.com/eclipse-pass/pass-ui/pkgs/container/pass-ui)
* [`pass-acceptance-testing`](https://github.com/eclipse-pass/pass-acceptance-testing)
  * [Release workflow](https://github.com/eclipse-pass/pass-acceptance-testing/actions/workflows/release.yml)

### Other projects
This must be released last because it relies on some Docker images that will be published during the release process of some of the above projects.

1. [`pass-docker`](https://github.com/eclipse-pass/pass-docker)
   * [Release workflow](https://github.com/eclipse-pass/pass-docker/actions/workflows/release.yml)
   * Packages:
      * [idp](https://github.com/orgs/eclipse-pass/packages/container/package/idp)
      * [demo-ldap](https://github.com/orgs/eclipse-pass/packages/container/package/demo-ldap)

### GitHub code release

You will have to manually create a GitHub release through the GitHub web interface to complete the release of each of these components. This can generally be done any time after the release automation completes successfully, since the release will be made against a tag created by the automation.

![Code release section](/docs/assets/github/releases/code-release-section.png)

* Navigate to the Releases section of the repository
* Click the "Draft new release" button near the top of the page
* Input release title, matching the release version used for the release (e.g. 0.5.0)
* Choose the release tag that was created during the automation
* Click on the "Generate release notes" button to generate a list of changes since the last release

## Triggering a GitHub workflow

Take [`eclipse-pass/main`](https://github.com/eclipse-pass/main) as an example.

* Navigate to the Actions tab in your target repository. Select the workflow you want to trigger. E.g. the Release workflow in `Publish: Release All`: https://github.com/eclipse-pass/main/actions/workflows/pass-complete-release.yml
* Click on the `Run workflow` button
* Input the branch you wish to run the release against and the desired "Release" and "Next dev" versions
  * Release version: full release version, e.g. 0.5.0. These versions should be regarded as immutable. These releases for Java projects cannot be updated or deleted.
  * Next development version: snapshot or development versions, e.g. 0.6.0-SNAPSHOT (please use all capital letters for the SNAPSHOT suffix). These development versions are intended to be overwritten.
* After a few seconds, a new workflow run should appear in the table with a yellow (in-progress) status dot. Clicking on that will allow you to monitor the run's progress by watching logs.

It is recommended that you monitor the automation after triggering it to make sure it completes successfully before moving on to release the next component.

![Release page screenshot](/docs/assets/github/releases/main-release-page.png)

## GitHub Personal Access Token Setup

Some GitHub workflows depend on the `JAVA_RELEASE_PAT` secret having permission to access all the eclipse-pass repositories and write packages.
You have to create a new classic Personal Access Token (PAT) to do the release (GitHub/Settings/Developer Settings/Personal access tokens/Tokens (classic)).
If you do so, set the expiration to 7 days, check the `repo` and the `write:packages` scope (subscopes under `repo`
and `write:packages` will be selected too).

How to set the secret in the main repository using the gh command line tool [GitHub CLI](https://cli.github.com/):
```
gh auth login
gh secret set JAVA_RELEASE_PAT --body <PAT_VALUE> --repo eclipse-pass/main
```
