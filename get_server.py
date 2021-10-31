import requests
import json
import os

LATEST = "latest"
RELEASE = "release"
SNAPSHOT = "snapshot"
REQUESTED_VERSION = os.getenv("SERVER_VERSION", LATEST)
VERSION_FILE = "SERVER_VERSION"

def get_latest_version(latest):
    return latest.get(RELEASE)

def get_version_data(versions, latest, id):
    if id == LATEST:
        id = get_latest_version(latest)

    result = list(filter(
        lambda item: item.get('id') == id,
        versions
    ))
    if len(result) == 1:
        return result[0]
    elif len(result) > 1:
        raise ValueError(f"Version {id} didn't return 1 result, it returned {len(result)}!")
    else:
        raise ValueError(f"Version {id} had no matches.")

def get_metadata_from_version(version):
    metadata = requests.get(version.get('url'))
    return json.loads(metadata.text)

def get_server_url_from_metadata(metadata):
    return metadata['downloads']['server']['url']

def write_url_file(url):
    with open(VERSION_FILE, "w") as f:
        return f.write(url)

if __name__ == "__main__":
    version_manifest = requests.get("https://launchermeta.mojang.com/mc/game/version_manifest_v2.json")
    version_json = json.loads(version_manifest.text)
    versions = version_json.get('versions')
    latest = version_json.get(LATEST)

    print(f"Attempting to get version {REQUESTED_VERSION}.")
    version = get_version_data(versions, latest, REQUESTED_VERSION)
    metadata = get_metadata_from_version(version)
    url = get_server_url_from_metadata(metadata)
    print(f"Found, writing url to VERSION file.")
    write_url_file(url)
