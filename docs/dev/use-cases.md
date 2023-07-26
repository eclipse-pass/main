# PASS Use Cases

## Historical documentation

### PASS Usecases

https://docs.google.com/document/d/16CAc1Yk0rp9fcCdnJxvROABAp0Hymv1dT-1AXVfl1qM/edit?usp=sharing

* Principal Investigator (PI) users can review their grants and create submissions to designated repositories based on applicable policies
* A PI can see past submissions made to PubMed Central
* A submitter can create a submission that satisfies one or more grants open access policies (PASS will determine which open access policies apply to a grant)
* A submitter can create one submission that the system will deposit into the JHU institutional repository and/or PubMed Central (potential support for more repositories in the future)

Other future looking use cases are enumerated in this document that are not currently implemented.

### Proxy submissions

https://docs.google.com/document/d/1wiYKfJ82vAuJP-hLQVPP5uE8ZGkCJW2Arrp4oH9oM8E/edit?usp=sharing

* As an authenticated user of PASS, I want to be able to prepare a submission on behalf of someone else
* As an authenticated user of PASS, I want to be able to approve and submit submissions that were created on my behalf

### Use case for funding agency submission system

https://docs.google.com/document/d/1U6m3ZeyjIV11w9TQqlNfdnyPSPMaaifc5IXaybEX8AU/edit?usp=sharing

Thoughts on what deposits to other external repositories may need. Predates discussions with NSF/DOE.


## UI focused Test scenarios

### Base test cases

https://docs.google.com/document/d/1BpyH2Fzjzkvpe1rVEpb5nx6rLyr-C-jQfFf6Cr7_Ex0/edit?usp=sharing

Scenario walkthroughs for several user paths through the PASS UI. Initially used for `pass-ui` unit/integration testing, however the top "base case" is run as an end-to-end test with `pass-acceptance-testing` that runs with each release. It may not make sense to include the rest of these in the end-to-end tests.

### Proxy submitter test cases

https://docs.google.com/document/d/1b4PXfLurzpHWlSyh-5CoLnjFrM79a87q60OJf7fpoZU/edit?usp=sharing

Testing scenario walkthroughs for the proxy submission feature, see [Proxy submissions](#proxy-submissions). Current end-to-end tests run through these scenarios in an incomplete way, since we do not have an email service hooked into the test environment.

## Features

As a user, I can

* Login with my JHED ID
* See if I have submissions that need review on my dashboard
* View my grants
* View my submissions made through PASS
* View my submissions that I made to PMC in the past
* Associate a publication to a new submission by its DOI or manually enter its name and journal during the submission process
* Search for my publications journal, if entering its information manually during the submission process
* Create a submission on behalf of a grant PI
* Create a submission associated with one or more of my grants
* See all public / open access policies that apply to the grants associated with my submission during the submission process
* See the repositories during the submission process that the system will deposit into
* Enter metadata required by all target repositories during the submission process
* Add the manuscript file and zero or more supporting files to the submission during the submission process
* See the submissions status after I complete the submission
* See identifiers assigned to a successful submission by a repository.
