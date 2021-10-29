# pca-report-generator-docker #

[![GitHub Build Status](https://github.com/cisagov/pca-report-generator-docker/workflows/build/badge.svg)](https://github.com/cisagov/pca-report-generator-docker/actions/workflows/build.yml)
[![CodeQL](https://github.com/cisagov/pca-report-generator-docker/workflows/CodeQL/badge.svg)](https://github.com/cisagov/pca-report-generator-docker/actions/workflows/codeql-analysis.yml)
[![Known Vulnerabilities](https://snyk.io/test/github/cisagov/pca-report-generator-docker/badge.svg)](https://snyk.io/test/github/cisagov/pca-report-generator-docker)

## Docker Image ##

[![Docker Pulls](https://img.shields.io/docker/pulls/cisagov/example)](https://hub.docker.com/r/cisagov/example)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/cisagov/example)](https://hub.docker.com/r/cisagov/example)
[![Platforms](https://img.shields.io/badge/platforms-amd64%20%7C%20arm%2Fv6%20%7C%20arm%2Fv7%20%7C%20arm64%20%7C%20ppc64le%20%7C%20s390x-blue)](https://hub.docker.com/r/cisagov/pca-report-generator-docker/tags)

This is a Docker project that uses the pca-report-library package.

The package is used for generating PCA reports with LaTeX and supporting scripts.

## Running ##

The following docker commands are available.

An alias can also be set beforehand to remove redundancy.

`pca-report-generator` - Builds PCA LaTeX report and complies the PDF

```console
docker run -v $(pwd):/home/cisa cisagov/pca-report-generator pca-report-generator
```

`pca-report-templates` - Exports the Report Mustache template and Manual data
file template

```console
docker run -v $(pwd):/home/cisa cisagov/pca-report-generator pca-report-templates
```

`pca-report-compiler` -  Compiles a PCA LaTeX report file,  still in development.

```console
docker run -v $(pwd):/home/cisa cisagov/pca-report-generator pca-report-compiler
```

`pca-report-generator-bash` - Will SSH into the container

```console
docker run -v $(pwd):/home/cisa cisagov/pca-report-generator pca-report-generator-bash
```

For debuging purposes - Will SSH into the container without an extra command

```console
docker run --rm -it --entrypoint bash cisagov/pca-report-generator
```

### Running with Docker Compose ###

1. Create a `docker-compose.yml` file similar to the one below to use [Docker Compose](https://docs.docker.com/compose/).

    ```yaml
    ---
    version: "3.7"

    services:
      pca-report-library:
        image: cisagov/pca-report-library
        volumes:
          - type: bind
            source: <your_log_dir>
            target: /home/cisa
        environment:
          - ECHO_MESSAGE="Hello from docker-compose"
    ```

1. Start the container and detach:

    ```console
    docker-compose up --detach
    ```

## Using secrets with your container ##

This container also supports passing sensitive values via [Docker
secrets](https://docs.docker.com/engine/swarm/secrets/).  Passing sensitive
values like your credentials can be more secure using secrets than using
environment variables.  See the
[secrets](#secrets) section below for a table of all supported secret files.

1. To use secrets, create a `quote.txt` file containing the values you want set:

    ```text
    Better lock it in your pocket.
    ```

1. Then add the secret to your `docker-compose.yml` file:

    ```yaml
    ---
    version: "3.7"

    secrets:
      quote_txt:
        file: quote.txt

    services:
      pca-report-library:
        image: cisagov/pca-report-library
        volumes:
          - type: bind
            source: <your_log_dir>
            target: /home/cisa
        environment:
          - ECHO_MESSAGE="Hello from docker-compose"
        secrets:
          - source: quote_txt
            target: quote.txt
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
    docker pull cisagov/pca-report-library
    ```

1. Recreate and run the container by following the [previous instructions](#running-with-docker).

<!-- Not yet pushed to Docker Hub. No Image tags.
## Image tags ##

The images of this container are tagged with [semantic
versions](https://semver.org) of the underlying example project that they
containerize.  It is recommended that most users use a version tag (e.g.
`:0.0.1`).

| Image:tag | Description |
|-----------|-------------|
|`cisagov/example:1.2.3`| An exact release version. |
|`cisagov/example:1.2`| The most recent release matching the major and minor version numbers. |
|`cisagov/example:1`| The most recent release matching the major version number. |
|`cisagov/example:edge` | The most recent image built from a merge into the `develop` branch of this repository. |
|`cisagov/example:nightly` | A nightly build of the `develop` branch of this repository. |
|`cisagov/example:latest`| The most recent release image pushed to a container registry.  Pulling an image using the `:latest` tag [should be avoided.](https://vsupalov.com/docker-latest-tag/) |

See the [tags tab](https://hub.docker.com/r/cisagov/example/tags) on Docker
Hub for a list of all the supported tags. -->

## Volumes ##

| Mount point | Purpose        |
|-------------|----------------|
| `/home/cisa`  |  Log storage   |

## Environment variables ##

### Required ###

| Name  | Purpose | Default |
|-------|---------|---------|
| `PCA_GENERATOR_IMAGE` | Docker image name. | `cisagov/pca-report-generator` |

<!-- ### Optional ### -->

<!-- | Name  | Purpose | Default |
|-------|---------|---------|
| `ECHO_MESSAGE` | Sets the message echoed by this container.  | `Hello World from Dockerfile` | -->

## Secrets ##

| Filename     | Purpose |
|--------------|---------|
| `quote.txt` | Replaces the secret stored in the example library's package data. |

<!-- ## Cross-platform builds ##

To create images that are compatible with other platforms, you can use the
[`buildx`](https://docs.docker.com/buildx/working-with-buildx/) feature of
Docker:

1. Copy the project to your machine using the `Code` button above
   or the command line:

    ```console
    git clone https://github.com/cisagov/example.git
    cd example
    ```

2. Create the `Dockerfile-x` file with `buildx` platform support:

    ```console
    ./buildx-dockerfile.sh
    ```

3. Build the image using `buildx`:

    ```console
    docker buildx build \
      --file Dockerfile-x \
      --platform linux/amd64 \
      --build-arg VERSION=0.0.1 \
      --output type=docker \
      --tag cisagov/example:0.0.1 .
    ``` -->

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
