# Eclipse PASS Demo

You can find more information about the Eclipse PASS demo [here](https://demo.eclipse-pass.org/demo.html). You can login to the Eclipse PASS demo directly [here](https://demo.eclipse-pass.org/login/jhu).

## Submission Workflow

1. Login with username: `nih-user` and password: `moo` 
2. Enter submission workflow by clicking on the "Start new submission" button
3. Enter DOI `10.1039/c7an01256j` into the DOI input field
4. PASS will retrieve data and populate the submission 'title' and 'journal' fields. You may need to wait a moment for this to occur.
5. Grants step: go to next step and select an NIH grant: Click anywhere on the row to select grant: R07EY012124 - Regulation of Synaptic Plasticity in Visual Cortex
  - When a grant is selected, it should appear in a separate “Grants added to submission” table, appearing above the “Available grants” table
7. Policies step: accept the currently selected policies, click Next to move on
  - Default selection for NIH policy is expected in most cases
8. Repositories step: accept the selected repositories, click Next to move on
  - JScholarship should be selected by default
7. Metadata (details) step: accept the pre-filled metadata, click Next to move on
  - Metadata form should have most fields pre-populated with data from the DOI with each such field being read-only
8. Files step: add any file to the submission, click Next to move on.
9. Review step: click Submit
  - Accept the Deposit Requirements for JScholarship popup by selecting the checkbox and clicking Next
  - Click "Confirm" on the next popup
10. Observe the “thank you” screen

## Known Limitations

### Mocked APIs

#### Authentication

  * Static set of users matched with demo sample PASS User entities
  * Current users (will be) used for acceptance testing, manual testing. Mix of fully faked users and custom users for the PASS team with faked credentials. These include Github usernames but no other real information
  * Cannot dynamically register new users or update passwords

#### Manuscript file lookup service 

Intended to lookup open access files that already exist online for a given DOI

* Fully mocked in browser to return a static dataset
* Returns a set of three files for a real DOI (`doi:10.1038/nature12373`)

#### File (upload) handling

File handling for PASS submissions. Used for CRUD operations for the manuscript and supporting files.

  * Fully mocked, not very nicely resulting in some errors in the JS console
  * While the File entity will appear on the submission review page, none will appear on the submission's details page. For "proxy" submissions, this means that a user cannot directly submit a pre-prepared submission, but instead will have to edit the submission and (re)attach the file to the submission
#### Metdata schema service

Returns the set of metadata requested for the set of target repositories for the in-progress submission as JSON schema to drive one or more forms

  * Fully mocked to return a common schema -- will not respond to different repository requirements

#### Repository service 

Gets a set of repositories that can or must recieve the submission

* Fully mocked, always returns PubMed Central and JScholarship

#### Policy service

Gets a set of open access policies that apply to the submission, determined after a user determines the target repositories. Technically part of the same service as the Repository service described above

* Fully mocked, always returns the PMC and JHU policies

### Other Known Issues

* Proxy submission can't be directly submitted after the preparer finalizes the submission due to the file handling
