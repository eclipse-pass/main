# Authentication and Authorization in Eclipse PASS

## Authentication

### User Interface Authentication

Authentication for the user interface occurs through the use of an authentication service provider (SP), [pass-auth](https://github.com/eclipse-pass/pass-auth), written as a node application employing the express framework and acting as a reverse proxy in front of pass-core and other api services.

`pass-auth` is configured to initiate a SAML exchange with a known identity provider (IDP) that supports [Shibboleth](https://shibboleth.atlassian.net/wiki/spaces/CONCEPT/overview). In response to a valid `authn` assertion against an IDP, `pass-auth` expects to receive and validate a Shibboleth SAML assertion against its assertion consumer service (ACS) URL. This assertion is expected to contain the following Shibboleth attributes:

```
'urn:oid:2.16.840.1.113730.3.1.241': 'displayName'
'urn:oid:1.3.6.1.4.1.5923.1.1.1.9': 'scopedAffiliation'
'urn:oid:0.9.2342.19200300.100.1.3': 'email'
'urn:oid:2.16.840.1.113730.3.1.3': 'employeeNumber'
'urn:oid:1.3.6.1.4.1.5923.1.1.1.1': 'employeeIdType'
'urn:oid:1.3.6.1.4.1.5923.1.1.1.6': 'eppn'
'urn:oid:2.5.4.42': 'givenName'
'urn:oid:2.5.4.4': 'surname'
'urn:oid:1.3.6.1.4.1.5923.1.1.1.13': 'uniqueId'
'urn:oid:0.9.2342.19200300.100.1.1': 'uniqueIdType'
```

These Shibboleth attributes are used to locate a user in `pass-core` and set up a user object on the session. Initially, `pass-auth` will use the `eppn` attribute to locate a user in `pass-core` via a request that uses basic authentication. On all subsequent requests to `pass-core`, `pass-auth` will add the following headers using the Shibboleth attributes stored on a session:

```
'Displayname'
'Mail'
'Eppn'
'Givenname'
'Sn'
'Affiliation'
'Employeenumber'
'unique-id'
'employeeid'
```

These headers are required by `pass-core` to authenticate and authorize requests to its API.

`pass-auth`, establishes a server side session and delivers a http-only cookie to the browser client which [`pass-ui`](https://github.com/eclipse-pass/pass-ui/) will use to establish a client side session in the user interface. This http-only cookie is delivered back to `pass-auth` by the user interface with every request which `pass-auth` will validate before it forwards on a request with the required Shibboleth headers to `pass-core`. 

This series of interactions is depicted as follows:

![pass auth interactions diagram](https://user-images.githubusercontent.com/6305935/229136863-dfae51f7-a032-4400-be71-66ad64169163.png)

### Basic Authentication

TODO

## Authorization

TODO
