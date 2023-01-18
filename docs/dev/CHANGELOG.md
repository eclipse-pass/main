## Release v0.2.0

This release is really a partial release - complete coverage of the functionality is the 0.1.0 release 
has not yet been completed. For test and demo purposes, this missing functionality is currently mocked, and
will be fully implemented in a future release.

Some major changes for v0.2.0 are

* Replacement of Fedora storage with Elide / postgres.
* Creation of a pass-core repository which contains REST services previously in separate projects/images
* Elimination of functionality written in Go in previous releases. These have
either been implemented in Java or eliminated
* Refactoring of authorization functionality in javascript, closer to the UI

