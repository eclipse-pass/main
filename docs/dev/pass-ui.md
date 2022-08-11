# pass-ui

https://github.com/eclipse-pass/pass-ui

## FAQ

### A procedure for manually testing proxy submissions:

1. Login as `nih-user` (password `moo`)
1. Do proxy submission on behalf of **Katrina Debnam**
    - Associate with ERIC grant
1. Verify that:
    - Submission contains the ERIC repository
    - Submission does not have external-submissions metadata
    - No click on ERIC link was required
    - The submissions detail page is as above
1. Login as `ed-user`
1. Verify the submissions detail page is as above
1. Approve the submission
1. Verify that
    - Submission does not contain the ERIC repository
    - Submission does contain a external-submissions attribute containing information about the ERIC repository
    - Click on ERIC link was required
    - The submissions detail page after submission is as above

The PASS ember app currently uses a custom Ember adapter to talk directly to [Fedora](https://fedorarepository.org/), our backend data store of choice. This has some implications to the development of the PASS Ember UI, especially when making changes to the Ember data model. 

---

### Updating the UI in `pass-docker`

_subject to change_

Steps to update `ember` container in `pass-docker`. All steps take place in `pass-docker`:

1. Edit `.env` file to point to the right commit hash, seen in Github
1. Edit `docker-compose.yml`: change the tag name for the `ember` container. The tag for `pass-ember` and `pass-ui-static` follow the convention: `<date>-<commit_hash>`. This does mean that changes must already be committed to Github for the tag to accurately reflect any real info.
1. `docker-compose build ember` to build the thing
1. Push image to Docker Hub. `docker-compose push ember`. When this completes, the success message will contain the sha256 hash for the image in Docker Hub. Copy this hash (including the `sha256:` part) and append it to the image in the `docker-compose.yml` file. It should now look similar to `oapass/ember:201806015-96d1830@sha256:07f8fa7c42b379f35ce88857affa992496df6f2424cff91fdce9c2c364839f4d`

If for some reason you don't get a sha256 hash when pushing a new image to Docker Hub, you can find it at any time with Docker. First get the image ID using `docker images`. Then run the command `docker inspect --format='{{index .RepoDigests 0}}' $IMAGE`, where `$IMAGE` is the Docker image ID you just found.

Once you make the above changes, `.env` and `docker-compose.yml` should have changes. Commit those changes to a branch and submit a PR against `pass-docker`.

---

### Changing the Ember data model

**The Ember Fedora Adapter**

The README from the [OA-PASS/ember-fedora-adapter](https://github.com/OA-PASS/ember-fedora-adapter) has some relevant information. This custom adapter receives data from Fedora formatted as [JSON-LD](https://json-ld.org/), a JSON based 
representation of RDF data. The fedora adapter then compacts the data, basically mapping the URI keys to shortened keys, based on a JSON-LD context that is configurable. The translated properties are what the adapter uses to create Ember data model objects. This means that the Ember data model and the JSON-LD context provided to the fedora adapter must be kept in sync (the context must also be kept in sync with the context being used by Fedora!).

Many changes to the Ember data model will break the context used by the fedora adapter. In order to see the model changes properly apply from the UI back down to the develompent Fedora back end, you must also provide an updated context. You will most likely have to stand up the context locally in order to test against the changes. This can be done using any means you want, such as standing up a local Apache instance to host the test context. When testing against this local context, you will also need to update the _pass-ember_ configurations to point to the correct place (all locations will be in your pass-ember repo):

**Fedora and ember-fedora-adapter relevant configs**
* `environment.js`:`ENV.fedora.context` must be updated to use your local test context
* `.env`:`COMPACTION_URI` must be updated to use your local test context

**Notes on adapter support**
* The adapter currently does not support string arrays
* The adapter currently does not support Ember transforms
* DS.belongsTo relationship must have `@id` JSON-LD type
* DS.hasMany relationship must have `@container: @set`, `@id` types

**Context Example **
Take these three properties defined in a sample context (note this by itself is not a valid context):

```
"Person": "pass:Person",
"person": {"@id": "pass:person"},
"author": {"@id": "pass:author", "@type": "@id"},
"authors": {"@id": "pass:authors",  "@container": "@set", "@type": "@id"},
```
* These properties can be used in any model object
* `Person` is a defined object type
* `person` maps to `DS.attr('string')` in Ember: note no `@type: @id`
* `author` the `@type: @id` marks it as a reference, will ultimately map to `DS.belongsTo('person')`
* `authors` has `@container: @set` which marks it as a Set of values, with the value type being `@id` (a reference to another object). This ultimately maps to `DS.hasMany('person')`

**Making changes to the Ember model**
You are free to change the Ember data model freely as you need in development. We can sync up a modified UI data model with the overall project data model when we think the changes are somewhat stable.

**You have to update the context when adding properties not already present in the context**

Whenever you make a change to the data model OR the test data:

* Make a change to the data model as needed
* Update a test context and make sure both Fedora and the fedora adapter are pointing to the test context as needed
* Update test data as needed
* Stop, clean, and start the Fedora docker image. This must be done to clear out the old (now obsolete) data from the Fedora container.
  ```
  docker-compose down
  docker system prune 
  docker-compose up
  ```

For development, you can run Fedora in a Docker container provided with the `pass-ember` repo with 
`docker-compose up`. This will bring Fedora up at `http://localhost:8080/fcrepo`.

---

## Resources
* [PASS data model](https://github.com/OA-PASS/pass-data-model)
* [ember-fedora-adapter README](https://github.com/OA-PASS/ember-fedora-adapter/blob/master/README.md) - for more information about the adapter that talks to Fedora
* [Fedora](https://fedorarepository.org/)
* [JSON-LD](https://json-ld.org/)







