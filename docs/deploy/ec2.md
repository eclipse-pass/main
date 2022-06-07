# PASS EC2 Deployment

This will document how to run PASS in EC2 by reusing the existing pass-docker setup.

## Background

The existing pass-docker setup is intended for local deployment. It uses a hard-coded hostname of `pass.local`. It includes a customized Service Provider and Identity Provider for authentication as well as DSpace for testing deposits. All of the other images are production images just configured for `pass.local`.
See the [pass-docker project](https://github.com/eclipse-pass/pass-docker) for more information.

## Configuration

First the server must have a hostname and certificate. Then pass-docker needs to be modified to use this hostname instead of `pass.local`. Docker images like `httpd-proxy`, `sp`, and `idp` have hard-codeds configurations for `pass.local` included in their pass-docker build setup. To avoid building new images, configuration files within those images that need to be changed, can be replaced by bind mounted ones modified with the new hostname. The rest of the images can be configured just with environment variables in `.env`. 

The simplest way to accomplish the hostname change is to do a global string replace of all files in pass-docker of `pass.local` to the new hostname. Then the files that need to be bind mounted are the files that have changed (find them with `git status`) that are part of `proxy`, `idp`, or `sp`. To find the location of these configuration files in the image, examine the relevant Dockerfile. In addition the certificate and key for the host will need to be bind mounted into the proxy. Generally the bind mounts should look like the below.

Bind mounts for proxy:
```
volumes:
  - ./newhost.crt:/etc/httpd/ssl/domain.crt
  - ./newhost.key:/etc/httpd/ssl/domain.key
  - ./httpd-proxy/etc-httpd/conf.d/httpd.conf:/etc/httpd/conf.d/httpd.conf
```

Bind mounts for idp:
```
 volumes:
   - ./idp/common/shibboleth-idp/conf/cas-protocol.xml:/opt/shibboleth-idp/conf/cas-protocol.xml
   - ./idp/common/shibboleth-idp/metadata/sp-metadata.xml:/opt/shibboleth-idp/metadata/sp-metadata.xml
   - ./idp/jhu/shibboleth-idp/conf/idp.properties:/opt/shibboleth-idp/conf/idp.properties
   - ./idp/jhu/shibboleth-idp/metadata/idp-metadata.xml:/opt/shibboleth-idp/metadata/idp-metadata.xml
```

Bind mounts for sp:
```
volumes:
  - ./sp/2.6.1/etc-httpd/conf.d/sp.conf:/etc/httpd/conf.d/sp.conf
  - ./sp/2.6.1/etc-shibboleth/idp-metadata.xml:/etc/shibboleth/idp-metadata.xml
  - ./sp/2.6.1/etc-shibboleth/shibboleth2.xml:/etc/shibboleth/shibboleth2.xml
```

## Additional complications

For the moment, instead of starting from pass-docker main, you may wish to start from the [200-test-deployment-of-pass-in-ec2-to-validate-startup-procedures-outside-of-jhu branch](https://github.com/eclipse-pass/pass-docker/tree/200-test-deployment-of-pass-in-ec2-to-validate-startup-procedures-outside-of-jhu). That branch contains a few fixes and updates and has the stack configured for sandbox.library.jhu.edu. A global string replace with a new hostname and a new certificate should be all that is needed.

## Running

Just do a `docker-compose up` like the standard pass-docker setup. Then you will be able to access all the url as described in the [pass-docker project](https://github.com/eclipse-pass/pass-docker). Note that dspace is on 8181 and fcrepo is on 8080 if you want to access them.


