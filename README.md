# OpenStack Swift Container

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
    docker run -e ST_AUTH_VERSION -e OS_USER_ID -e OS_PASSWORD -e OS_PROJECT_ID -e OS_AUTH_URL openstack-swift-container <args>
    ```
    If the image is unable to authenticate against your service provider, it will show an error message and exit from execution.

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