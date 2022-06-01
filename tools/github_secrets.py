import argparse
import json
from base64 import b64encode

try:
    import requests
except:
    print("Please run: pip install requests")
    exit()

try:
    from nacl import encoding, public
except:
    print("Please run: pip install pynacl")
    exit()

parser = argparse.ArgumentParser(prog='github_secrets.py')
parser.add_argument('-u', '--user', required=True, nargs='?', action="store", dest='user', help='Your GitHub username')
parser.add_argument('-t', '--token', required=True, nargs='?', action="store", dest='token', help='A GitHub personal access token with repo access')
parser.add_argument('-r', '--repo', required=True, nargs='?', action="store", dest='repo', help='The name of the GitHub repository containing the secret')
parser.add_argument('-n', '--name', required=True, nargs='?', action="store", dest='name', help='Name of the secret')
parser.add_argument('-v', '--value', required=False, nargs='?', action="store", dest='value', help='The unencoded value to be set for the secret. If not included, the secret metadata will be fetched.')
parser.add_argument('-e', '--environment', required=False, nargs='?', action="store", dest='environment', help='The environment for secrets.')
argresults = parser.parse_args()

eclipsePassRoot = "https://api.github.com/repos/eclipse-pass/"
headers = {"Accept":"application/vnd.github.v3+json"}

if argresults.environment:
    # First we get the repository info to find its ID
    result = requests.get(eclipsePassRoot + argresults.repo, headers=headers, auth=(argresults.user, argresults.token))

    repoData = result.json()
    repoId = str(repoData["id"])
    repoUrl = "https://api.github.com/repositories/" + repoId + "/environments/" + argresults.environment
else:
    repoUrl = eclipsePassRoot + argresults.repo + "/actions"

if argresults.value:
    # First we fetch the public key to use for encoding the secret
    result = requests.get(repoUrl + "/secrets/public-key", headers=headers, auth=(argresults.user, argresults.token))
    publicKeyData = result.json()

    # Encrypt the secret before sending it
    public_key = publicKeyData["key"]
    public_key = public.PublicKey(public_key.encode("utf-8"), encoding.Base64Encoder())
    sealed_box = public.SealedBox(public_key)
    encrypted = sealed_box.encrypt(argresults.value.encode("utf-8"))
    encodedValue = b64encode(encrypted).decode("utf-8")

    # Send the request to set the secret
    data = '{"encrypted_value":"' + encodedValue + '","key_id":"' + publicKeyData["key_id"] + '"}'
    secretUrl = repoUrl + "/secrets/" + argresults.name
    result = requests.put(secretUrl, data=data, headers=headers, auth=(argresults.user, argresults.token))
    if result.status_code in [requests.codes.no_content, requests.codes.created]:
        print("\nYour secret has been updated!")
    else:
        print("\nERROR! Your secret was not updated: " + result.reason + "(" + str(result.status_code) + ")")
else:
    result = requests.get(repoUrl + "/secrets/" + argresults.name, headers=headers, auth=(argresults.user, argresults.token))
    secretMetadata = result.json()
    print(json.dumps(secretMetadata))
