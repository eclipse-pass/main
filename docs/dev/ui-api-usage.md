A UI centric view on PASS APIs as of PASS v0.1.0. These are a list of services consumed by the UI along with brief descriptions of each. These descriptions do not include full configurations of the services, but includes only those configurations needed for the UI to work, typically just the URL endpoint for the services. This documentation is meant to describe the APIs as they were for our initial versions of PASS to inform ongoing development and not necessarily meant to be carried forward.

- [Metadata Schema Service](#metadata-schema-service)
- [DOI Service](#doi-service)
- [User Service](#user-service)
- [Download Service](#download-service)
	- [Lookup](#lookup)
	- [Download](#download)
- [Policy Service](#policy-service)
	- [Policies](#policies)
	- [Repositories](#repositories)
- [PASS Data Entities](#pass-data-entities)
	- [Create](#create)
	- [Read](#read)
		- [Single](#single)
		- [Multiple](#multiple)
	- [Update](#update)
	- [Delete](#delete)
- [Misc operations](#misc-operations)
	- [Setup Fedora](#setup-fedora)
	- [Clear](#clear)

# Metadata Schema Service
https://github.com/eclipse-pass/pass-metadata-schemas

Retrieve an ordered list of relevant [JSON schemas](https://json-schema.org/) describing metadata given a list of PASS Repositories.

|  |  |
| --- | --- |
| URL | `/schemaservice` |
| config | `SCHEMA_SERVICE_URL` |
| Method | POST |
| Headers | "Content-Type: application/json; charset=utf-8" <strong>OR</strong><br> "Content-Type: text/plain" |
| Parameters | `?merge=true` (optional) |
| body | Array of PASS Repository object IDs (for type json) <strong>OR</strong><br> List of PASS Repository object IDs, separated by newline characters (plain text) |
| Response | List of JSON schemas |

Sample request:
```
POST
	Content-Type: application/json; charset=utf-8

Body:
[
	"https://pass.jhu.edu/fcrepo/rest/repositories/foo",
	"https://pass.jhu.edu/fcrepo/rest/repositories/bar"
]
```

Sample response:
``` JSON
[
	{
	  "title": "Common schema",
	  "type": "object",
	  "definitions": …(all of the common fields)
	},
	{
	  "title": "Foo schema",
	  "type": "object",
	  "definitions": ….
	},
	{
	   "title": "NIHMS schema",
	   "type": "object",
	   "$schema": "http://json-schema.org/draft-07/schema#",
	   "definitions": {
	       "form": {
	           "title": "This is the title Alpaca displays in the UI",
	           "type": "object",
	           "required": ["journal-NLMTA-ID"],
	           "properties": {
	               "journal-NLMTA-ID": {"$ref": "http://localhost:8080/schemas/global.json#/properties/journal-NLMTA-ID"}
	           },
		  "options": {"$ref": "http://localhost:8080/schemas/global.json#/options"}
	       },
	       "prerequisites": {
	           "title": "prerequisites",
	           "type": "object",
	           "required": ["authors"],
	           "properties": {
	               "authors": {"$ref": "http://localhost:8080/schemas/global.json#/properties/authors"}
	           }
	       }
	   },
	   "allOf": [
	       {"$ref": "http://localhost:8080/schemas/global.json#"},
	       {"$ref": "#/definitions/prerequisites"},
	       {"$ref": "#/definitions/form"}
	   ]
	}
]
```

The intent of these schemas is to drive a dynamic form system for metadata entry in the UI. We currently use [AlpacaJS](http://www.alpacajs.org/) to parse the schemas and generate the forms client side

If the `merge` parameter is set with any value, the service will merge all relevant schemas into a single schema and Response that merged schema to the requesting client.

* [JSON Schema](https://json-schema.org/)
* [AlpacaJS](http://www.alpacajs.org/)

**Errors**

| Code | Description |
--- | ---
`409` | Service was unable to merge the schemas together. This will only occur if the `merge` parameter is set. If this error occurs, the client should issue a new request for the unmerged schemas

---

# DOI Service

https://github.com/eclipse-pass/pass-doi-service

Interacts with Crossref to get data about a given DOI. [See example DOI data](https://gist.github.com/jabrah/c268c6b027bd2646595e266f872c883c)
Get an ID to a PASS Journal object represented by the DOI and the raw Crossref data for the given DOI

The UI does some data transformation to trim the Crossref data and light processing to fit it into our PASS Publication model before persisting the Publication.

|  |  |
| --- | --- |
| URL | `/doiservice/journal` |
| Config | `DOI_SERVICE_URL` |
| Method | `GET` |
| Parameters | `?doi` (string) a DOI |
| Headers | `Accept: "application/json; charset=utf-8" |
| Body |  |
| Response | <pre>{<br>	"crossref": {<br>		"message": { ... }, // Raw data from Crossref[^xref]<br>	},<br>	"journal-id": ""<br>}</pre> |

In the UI, we ultimately process the Crossref data into a Publication model object and add anything else we can into the Submission's metadata blob to fit the submission's known metadata schema. Should these transformations be done server side, or is there a reason that it needs to be done client side (client review & approval?) - see `doi#doiToMetadata()`

[^xref]: [Crossref data format](https://github.com/CrossRef/rest-api-doc/blob/master/api_format.md )

---

# User Service

Get the currently logged in User.

|  |  |
| --- | --- |
| URL | `/pass-user-service/whoami` |
| Config | `USER_SERVICE_URL` |
| Method | `GET` |
| Parameters | `userToken`: auth token |
| Headers | `Accept: "application/json; charset=utf-8"` |
| Body |  |
| Response | A PASS User object |

# Download Service

https://github.com/eclipse-pass/pass-download-service

Allows client lookups and downloads of previously uploaded files associated with Submissions.

## Lookup 

Get a list of open access copies for the given DOI

|  |  |
| --- | --- |
| URL | `/downloadservice/lookup` |
| Config | `MANUSCRIPT_SERVICE_LOOKUP_URL` |
| Method | `GET` |
| Parameters | `userToken`: auth token |
| Headers | `Accept: "application/json; charset=utf-8"` |
| Body |  |
| Response | Array: <pre>[<br>  {<br>    "url": "",<br>    "name": "",<br>    "type": "",<br>    "source": "",<br>    "repositoryLabel": ""<br>  },<br>  ...<br>]</pre> |

* `url`: URL where the manuscript can be retrieved
* `name` file name
* `type` file MIME type
* `source`: Source of the file (e.g. "Unpaywall")
* `repositoryLabel`: Human readable label of the repository where the manuscript is stored

## Download

|  |  |
| --- | --- |
| URL | `/downloadservice/download` |
| Config | `MANUSCRIPT_SERVICE_DOWNLOAD_URL` |
| Method | `GET` |
| Parameters | <p>`doi` (string) publication DOI</p><p>`url` download URL of the file</p> |
| Headers |  |
| Body |  |
| Response | The file, downloaded via the backend download service |

Response 

Not sure whether or not this is used by the UI

---

# Policy Service

https://github.com/eclipse-pass/pass-policy-service

[Included docs](https://github.com/eclipse-pass/pass-policy-service/blob/main/web/README.md)

Config: `POLICY_SERVICE_URL` base URL for the policy service

## Policies

Get a list of policies that apply to a submission, given its PASS ID (URI). Typically only used with in-progress submissions.

|  |  |
| --- | --- |
| URL | `/policy-service/policies` |
| Config | `POLICY_SERVICE_POLICY_ENDPOINT` |
| Method | `GET` or `POST` |
| Parameters | `submission` a submission ID |
| Headers | `Content-Type: application/x-www-form-urlencoded` |
| Body | `submission=submission_id` if a POST |
| Response | An array of PASS Policy object IDs |

Sample request:
```
GET /policy-service/policies?submission=<submission_id>
```

Sample response:
``` JSON
[
 {
   "id": "http://pass.local:8080/fcrepo/rest/policies/2d/...",
   "type": "funder"
 },
 {
   "id": "http://pass.local:8080/fcrepo/rest/policies/63/...",
   "type": "institution"
 }
]
```

The `type` property identifies the source of the policy and will only take the values of `funder` or `institution`.

## Repositories

|  |  |
| --- | --- |
| URL | `policy-service/repositories` |
| Config | `POLICY_SERVICE_REPOSITORY_ENDPOINT` |
| Method | `GET` or `POST` |
| Parameters | `submission` submission ID |
| Headers | `Content-Type: application/x-www-form-urlencoded` |
| Body | `submission=submission_id` if a POST |
| Response | JSON object containing required, optional, and choice repositories |

Sample request:
```
GET /policy-service/repositories
```

Sample response:
``` JSON
{
	"required": [
		{
			"url": "http://pass.local/fcrepo/rest/repositories/1",
			"selected": true
		}
	],
	"one-of": [
		[
			{
				"url": "http://pass.local/fcrepo/rest/repositories/2",
				"selected": true
			},
			{
				"url": "http://pass.local/fcrepo/rest/repositories/3",
				"selected": false
			}
		],
		[
			{
				"url": "http://pass.local/fcrepo/rest/repositories/4",
				"selected": true
			},
			{
				"url": "http://pass.local/fcrepo/rest/repositories/5",
				"selected": false
			}
		]
	],
	"optional": [
		{
			"url": "http://pass.local/fcrepo/rest/repositories/6",
			"selected": true
		}
	]
}
```
* `selected` status denotes default choices, if the user is presented with options
* `required` submissions MUST be depositied into these repositories
* `one-of` array of arrays presenting choice-sets. The submission must be deposited into at least one from each choice-set. In this example, the submission must be deposited into repository (2 OR 3) AND (4 OR 5). 
* `optional` the submission MAY be submitted to these repositories

---

# PASS Data Entities

All CRUD requests for PASS data entities route through the [`pass-ember-adapter`](https://github.com/eclipse-pass/pass-ember-adapter).

Headers:
* `Accept: application/ld+json; profile="http://www.w3.org/ns/json-ld#compacted"`
* `Prefer: return=representation; omit="http://fedora.info/definitions/v4/repository#ServerManaged"`
* `Authorization=<...>`

All operations use these headers, unless otherwise specified.

| Operation | Adapter Function | URL | Headers | Parameters
| --- | --- |
| 

## Create

|  |  |
| --- | --- |
| Adapter function | `#createRecord` |
| URL | `<fedora_base_url>/<container_name>` |
| Config |  |
| Method | `POST` |
| Parameters |  |
| Headers | +`Content-Type: application/ld+json; charset=utf-8` |
| Body | JSON-LD serialized data |
| Response | Fedora responds with the newly created entity ID in the `response.Location` header |

## Read

### Single

|  |  |
| --- | --- |
| Adapter function | `#findRecord` |
| URL | Entity ID |
| Config |  |
| Method | `GET` |
| Parameters |  |
| Headers |  |
| Body |  |
| Response | The entity, serialized as an Ember model object |

### Multiple

|  |  |
| --- | --- |
| Adapter function | `#query` |
| URL | `/pass/_search` |
| Config | `FEDORA_ADAPTER_ES` |
| Method | `POST` |
| Parameters |  |
| Headers | `Content-Type: application/json; charset=utf-8` |
| Body | An Elasticsearch query in JSON format |
| Response | List of matching entities |

|  |  |
| --- | --- |
| Adapter function | `#findAll` |
| URL | `/pass/_search` |
| Config | `FEDORA_ADAPTER_ES` |
| Method | `POST` |
| Parameters |  |
| Headers | `Content-Type: application/json; charset=utf-8` |
| Body | An Elasticsearch query that will match all entities of a given model |
| Response | List of entities |

## Update

|  |  |
| --- | --- |
| Adapter function | `#updateRecord` |
| URL | Entity ID |
| Config |  |
| Method | `PATCH` |
| Parameters |  |
| Headers | `Content-Type: application/merge-patch+json; charset=utf-8" |
| Body | JSON-LD serialized entity |
| Response |  |

## Delete

Will delete the entity then delete it's tombstone.

|  |  |
| --- | --- |
| Adapter function | `#deleteRecord` |
| URL | Entity ID AND (entity_ID/fcr:tombstone) |
| Config |  |
| Method | `DELETE` |
| Parameters |  |
| Headers |  |
| Body |  |
| Response |  |

# Misc operations

## Setup Fedora

`#setupFedora`

Remnant of the original demo code, now only called in tests. Calls the Delete then Create functions for all known model types in order to create the fresh containers in Fedora.

## Clear 

Only used in testing for this adapter.

|  |  |
| --- | --- |
| Adapter function | `#clearElasticsearch` |
| URL | `<ES_url>/_doc/_delete_by_query?conflicts=proceed&refresh` |
| Config |  |
| Method | `POST` |
| Parameters | Static/baked into URL |
| Headers | Content-Type: application/json` |
| Body | `{ query: { match_all: {} } }` |
| Response |  |


