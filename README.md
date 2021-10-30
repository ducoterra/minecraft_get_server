# Minecraft Server Getter

Get the url for any minecraft server version

## Usage

### Python

Since this script is designed to be used in Docker it works with
environment variables. Set SERVER_VERSION=<desired version> and
get_server.py will write a file called "SERVER_VERSION" with the url
to download the version requested.

```bash
export SERVER_VERSION=1.16.4
python get_server.py
```

### Docker

This is the intended way to run get_server. The get_server image saves
the SERVER_VERSION file to /downloads. Mounting /downloads to `pwd` will
allow the image to write to your current directory.

```bash
docker run -it -e SERVER_VERSION=1.16.4 -v $(pwd):/downloads ducoterra/get-minecraft:latest
```

## Build

To create a new version increment the version in the VERSION file.

```bash
# Mac M1 Only
make buildx-context

make build
make push
```
