# pca-report-generator-docker #

[![GitHub Build Status](https://github.com/cisagov/pca-report-generator-docker/workflows/build/badge.svg)](https://github.com/cisagov/pca-report-generator-docker/actions/workflows/build.yml)
[![CodeQL](https://github.com/cisagov/pca-report-generator-docker/workflows/CodeQL/badge.svg)](https://github.com/cisagov/pca-report-generator-docker/actions/workflows/codeql-analysis.yml)
[![Known Vulnerabilities](https://snyk.io/test/github/cisagov/pca-report-generator-docker/badge.svg)](https://snyk.io/test/github/cisagov/pca-report-generator-docker)

## Docker Image ##

[![Docker Pulls](https://img.shields.io/docker/pulls/cisagov/example)](https://hub.docker.com/r/cisagov/example)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/cisagov/example)](https://hub.docker.com/r/cisagov/example)
[![Platforms](https://img.shields.io/badge/platforms-amd64%20%7C%20arm%2Fv6%20%7C%20arm%2Fv7%20%7C%20arm64%20%7C%20ppc64le%20%7C%20s390x-blue)](https://hub.docker.com/r/cisagov/pca-report-generator-docker/tags)

This is a Docker project that containerizes the [pca-report-library](https://github.com/cisagov/pca-report-library)
package, which can be used to generate Phishing Campaign Assessment (PCA) reports.

## Running ##

The following Docker commands are available.

Use `--entrypoint` to select which command within `pca-report-library` to
execute:

- `pca-report-generator` (this is the default entrypoint)
- `pca-report-templates`
- `pca-report-compiler`

If no additional parameters are supplied, help text will be output.
See below for examples:

`pca-report-generator` - Create a PCA report as a PDF:

```console
docker run --volume $(pwd):/home/cisa cisagov/pca-report-library:0.0.1 MY_ASSESSMENT_ID
```

`pca-report-templates` - Export the PCA manual data file template or Mustache
template:

```console
docker run --volume $(pwd):/home/cisa --entrypoint pca-report-templates cisagov/pca-report-library:0.0.1 --manualData

docker run --volume $(pwd):/home/cisa --entrypoint pca-report-templates cisagov/pca-report-library:0.0.1 --LaTeX
```

`pca-report-compiler` -  Compile a PCA LaTeX report file (still in
development):

```console
docker run --volume $(pwd):/home/cisa --entrypoint pca-report-templates cisagov/pca-report-library:0.0.1 MY_REPORT.tex
```

`pca-report-generator-bash` - Starts up a `bash` shell in the container

```console
docker run -v $(pwd):/home/cisa --entrypoint pca-report-generator-bash cisagov/pca-report-generator
```

### Running with Docker Compose ###

1. Create a `docker-compose.yml` file similar to the one below to use [Docker Compose](https://docs.docker.com/compose/).

    ```yaml
    ---
    version: "3.7"

    services:
      pca-report-library:
        image: cisagov/pca-report-library:0.0.1
        volumes:
          - type: bind
            source: <your_log_dir>
            target: /home/cisa
    ```

1. Start the container and detach:

    ```console
    docker-compose up --detach
    ```

## Updating your container ##

### Docker Compose ###

1. Pull the new image from Docker Hub:

    ```console
    docker-compose pull
    ```

1. Recreate the running container by following the [previous instructions](#running-with-docker-compose):

    ```console
    docker-compose up --detach
    ```

### Docker ###

1. Stop the running container:

    ```console
    docker stop <container_id>
    ```

1. Pull the new image:

    ```console
    docker pull cisagov/pca-report-library:0.0.1
    ```

1. Recreate and run the container by following the [previous instructions](#running-with-docker).

## Image tags ##

The images of this container are tagged with [semantic
versions](https://semver.org) of the underlying example project that they
containerize.  It is recommended that most users use a version tag (e.g.
`:0.0.1`).

| Image:tag | Description |
|-----------|-------------|
|`cisagov/pca-report-library:0.0.1`| An exact release version. |
|`cisagov/pca-report-library:0.0`| The most recent release matching the major and minor version numbers. |
|`cisagov/pca-report-library:0`| The most recent release matching the major version number. |
|`cisagov/pca-report-library:edge` | The most recent image built from a merge into the `develop` branch of this repository. |
|`cisagov/pca-report-library:nightly` | A nightly build of the `develop` branch of this repository. |
|`cisagov/pca-report-library:latest`| The most recent release image pushed to a container registry.  Pulling an image using the `:latest` tag [should be avoided.](https://vsupalov.com/docker-latest-tag/) |

See the [tags tab](https://hub.docker.com/r/cisagov/example/tags) on Docker
Hub for a list of all the supported tags.

## Volumes ##

There are no volumes for this container.
<!-- | Mount point | Purpose        |
|-------------|----------------|
| `/home/cisa`  |  Log storage   | -->

## Ports ##

There are no ports exposed by this container.

<!--
The following ports are exposed by this container:

| Port | Purpose        |
|------|----------------|
| 8080 | Example only; nothing is actually listening on the port |

The sample [Docker composition](docker-compose.yml) publishes the
exposed port at 8080.
-->

## Environment variables ##

<!-- ### Required ###

| Name  | Purpose | Default |
|-------|---------|---------|
| `` |  |  | -->

### Optional ###

| Name  | Purpose | Default |
|-------|---------|---------|
| `CISA_HOME` | Sets up as the working directory.  | `/home/cisa` |
| `PCA_REPORT_TOOLS_SRC` | Set as the directory for the pca-report-library codebase.  | `/usr/src/pca-report-tools` |

## Secrets ##

There are no secrets for this container.
<!-- | Filename     | Purpose |
|--------------|---------|
| `quote.txt` | Replaces the secret stored in the example library's package data. | -->

## Building from source ##

Build the image locally using this git repository as the [build context](https://docs.docker.com/engine/reference/commandline/build/#git-repositories):

```console
docker build \
  --build-arg VERSION=0.0.1 \
  --tag cisagov/pca-report-library:0.0.1 \
  https://github.com/cisagov/pca-report-library.git#develop
```

## Cross-platform builds ##

To create images that are compatible with other platforms, you can use the
[`buildx`](https://docs.docker.com/buildx/working-with-buildx/) feature of
Docker:

1. Copy the project to your machine using the `Code` button above
   or the command line:

    ```console
    git clone https://github.com/cisagov/pca-report-library.git
    cd example
    ```

1. Create the `Dockerfile-x` file with `buildx` platform support:

    ```console
    ./buildx-dockerfile.sh
    ```

1. Build the image using `buildx`:

    ```console
    docker buildx build \
      --file Dockerfile-x \
      --platform linux/amd64 \
      --build-arg VERSION=0.0.1 \
      --output type=docker \
      --tag cisagov/pca-report-library:0.0.1 .
    ```

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
