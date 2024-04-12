# PASS EC2 Deployment

This will document how to run PASS in EC2 by reusing the existing pass-docker setup.

## Background

The existing pass-docker setup is intended for local deployment. It uses a hard-coded hostname of `localhost`. It includes a customized Identity Provider for authentication as well as DSpace for testing deposits. All of the other images are production images just configured for `localhost`. See the [pass-docker project](https://github.com/eclipse-pass/pass-docker) for more information.

## Configuration

First the server must have a hostname and certificate. Then the pass-core image which is a Spring Boot application needs to be modified to use this hostname instead of `localhost`.
See [https://docs.spring.io/spring-boot/reference/features/ssl.html] for instructions.

Variables that that mention `localhost` in the `.env` need to be changed.

## Running

Follow the [pass-docker project](https://github.com/eclipse-pass/pass-docker) instructions to run.

