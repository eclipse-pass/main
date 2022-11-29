# CNI Dec 2022 Demo

## Mocked APIs

### Authentication

  * Static set of users matched with demo sample PASS User entities
  * Current users (will be) used for acceptance testing, manual testing. Mix of fully faked users and custom users for the PASS team with faked credentials. These include Github usernames but no other real information
  * Cannot dynamically register new users or update passwords

### Manuscript file lookup service 

Intended to lookup open access files that already exist online for a given DOI

* Fully mocked in browser to return a static dataset
* Returns a set of three files for a real DOI (`doi:10.1038/nature12373`)

### File (upload) handling

File handling for PASS submissions. Used for CRUD operations for the manuscript and supporting files.

  * Fully mocked, not very nicely resulting in some errors in the JS console
  * While the File entity will appear on the submission review page, none will appear on the submission's details page. For "proxy" submissions, this means that a user cannot directly submit a pre-prepared submission, but instead will have to edit the submission and (re)attach the file to the submission
### Metdata schema service

Returns the set of metadata requested for the set of target repositories for the in-progress submission as JSON schema to drive one or more forms

  * Fully mocked to return a common schema -- will not respond to different repository requirements

### Repository service 

Gets a set of repositories that can or must recieve the submission

* Fully mocked, always returns PubMed Central and JScholarship

### Policy service

Gets a set of open access policies that apply to the submission, determined after a user determines the target repositories. Technically part of the same service as the Repository service described above

* Fully mocked, always returns the PMC and JHU policies

## Known Issues

* Proxy submission can't be directly submitted after the preparer finalizes the submission due to the file handling
