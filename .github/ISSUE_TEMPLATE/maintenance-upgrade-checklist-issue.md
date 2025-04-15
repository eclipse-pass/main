---
name: Maintenance Upgrade Checklist Issue
about: PASS Maintenance Upgrade Checklist includes all the necessary steps when doing a maintenance upgrade of PASS.
title: 'Maintenance Upgrade Checklist MAJOR.MINOR.PATCH'
assignees: ''

---

# Maintenance Upgrade Checklist

|                        |                            |
|------------------------|----------------------------|
| Target Release version | MAJOR.MINOR.PATCH          |

- [ ] Upgrade dependencies to latest stable version in pass-core
- [ ] Upgrade dependencies to latest stable version in pass-support modules
- [ ] Upgrade dependencies to latest stable version in pass-ui
- [ ] Upgrade dependencies to latest stable version in pass-acceptance-testing
- [ ] Upgrade maven plugins to latest stable version in main
- [ ] After dependencies are upgraded, run SBOMs through [OWASP Dependency Track](https://owasp.org/www-project-dependency-track/)
to ensure there are no outstanding Security Vulnerabilities.
- [ ] Upgrade Dockerfile base image in pass-core if needed
- [ ] Upgrade Dockerfile base image in pass-support modules if needed
- [ ] Upgrade Dockerfile base image in pass-ui if needed
- [ ] In pass-core and pass-support modules, check java version to determine if upgrade is needed
- [ ] In pass-ui and pass-acceptance-testing, check node version to determine if upgrade is needed