# OpenStack Swift Container

![CI/CD](https://github.com/iksaku/openstack-swift-container/workflows/CI/CD/badge.svg)

## Table of Contents
- [Tags](#tags)
- [Description](#description)
- [Usage](#usage)
  - [Authentication](#authentication)
  - [Skip Authentication Pre-Check](#skip-authentication-pre-check)
  - [Swift Commands](#swift-commands)

## Tags
- [`ussuri-dev`, `3-dev`, `3.9-dev`, `3.9.0-dev`](https://github.com/iksaku/openstack-swift-container/blob/master/Dockerfile)
- [`train`, `3`, `3.8`, `3.8.1`](https://github.com/iksaku/openstack-swift-container/blob/train/Dockerfile)
- [`stein`, `3.7`, `3.7.1`](https://github.com/iksaku/openstack-swift-container/blob/stein/Dockerfile)

## Description
This container comes with an installation of OpenStack's Swift and Keystone CLI clients.

If you're not familiarized with the Swift client, checkout the following links:
  - [What is OpenStack Swift?](https://wiki.openstack.org/wiki/Swift).
  - [OpenStack Swift's Documentation](https://docs.openstack.org/swift/stein/)
  - [Swift CLI Client](https://docs.openstack.org/python-swiftclient/stein/)

## Usage
In order to authenticate against your service provider, you must pass your Swift credentias via environment variables. If you don't quite get it, please refer to the following links:
  - [Swift Authentication via Environment Variables](https://docs.openstack.org/python-swiftclient/stein/cli/index.html#authentication)
  - [Passing Environment Variables via `docker run`](https://docs.docker.com/v17.12/edge/engine/reference/commandline/run/#set-environment-variables--e-env-env-file)

Uppon running this image, it will automatically execute the `swift` command, followed by any arguments you provide.

### Examples
  - #### Authentication
    Assume we're going to authenticate using Keystone v3 to a generic Object Storage service provider. As Swift's documentation states for [Authentication](https://docs.openstack.org/python-swiftclient/stein/cli/index.html#authentication), we will need to pass the following variables (filled with credentials) to our docker image:

    | Variables       | Value                             |
    | --------------- | --------------------------------- |
    | ST_AUTH_VERSION | 3                                 |
    | OS_USER_ID      | abcdef0123456789abcdef0123456789  |
    | OS_PASSWORD     | password                          |
    | OS_PROJECT_ID   | 0123456789abcdef0123456789abcdef  |
    | OS_AUTH_URL     | https://api.example.com:5000/v3   |

    In order to tell docker to include those variables during runtime, we need to execute the following:

    ```sh
    docker run -e ST_AUTH_VERSION -e OS_USER_ID -e OS_PASSWORD -e OS_PROJECT_ID -e OS_AUTH_URL openstack-swift-container --version
    ```

    If the image is unable to authenticate against your service provider, it will show an error message and exit from execution.

  - #### Skip Authentication Pre-Check
    By default, this image does a pre-check of authentication against your service provider before running your specified Swift command.
    You can disable this behaviour by passing the `INPUT_AUTH_CHECK` environment variable with a string value of `'false'`:

    ```sh
    INPUT_AUTH_CHECK='false'
    docker run -e ST_AUTH_VERSION -e OS_USER_ID -e OS_PASSWORD -e OS_PROJECT_ID -e OS_AUTH_URL -e INPUT_AUTH_CHECK openstack-swift-container --version
    ``` 

  - #### Swift Commands
    To execute [Swift Commands](https://docs.openstack.org/python-swiftclient/stein/cli/index.html#cli-commands) with this image, we need to call them via `args` in the `docker run` command.

    Let's say we want to `list` our available containers. We must run:
    ```sh
    docker run <--env ...> openstack-swift-container list
    ```

    If we would like to upload `Log.1` and `Log.2` files to our `logs` container, we could run:
    ```sh
    docker run <--env ...> openstack-swift-container upload logs Log.1 Log.2
    ```