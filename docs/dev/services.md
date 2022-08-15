- [Metadata Schema Service](#metadata-schema-service)
    - [Errors](#errors)
    - [Links](#links)
- [DOI Service](#doi-service)
    - [Links](#links-1)

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
| Returns | List of JSON schemas |

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

If the `merge` parameter is set with any value, the service will merge all relevant schemas into a single schema and return that merged schema to the requesting client.

### Errors

| Code | Description |
--- | ---
`409` | Service was unable to merge the schemas together. This will only occur if the `merge` parameter is set. If this error occurs, the client should issue a new request for the unmerged schemas

### Links
* [JSON Schema](https://json-schema.org/)
* [AlpacaJS](http://www.alpacajs.org/)

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
| Body | N/A |
| Returns | <pre>{<br>	"crossref": {<br>		"message": { ... }, // Raw data from Crossref<br>	},<br>	"journal-id": ""<br>}</pre> |

In the UI, we ultimately process the Crossref data into a Publication model object and add anything else we can into the Submission's metadata blob to fit the submission's known metadata schema. Should these transformations be done server side, or is there a reason that it needs to be done client side (client review & approval?) - see `doi#doiToMetadata()`

### Links
* [Crossref data format](https://github.com/CrossRef/rest-api-doc/blob/master/api_format.md )
