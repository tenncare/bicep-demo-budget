# Docker Notes

I am not happy about having to use homebrew to install azure-cli, as I have avoided installing it on my system so far
and don’t want to start now. I don’t like how it modifies so many things in the file system.

So, I want to use the docker version instead, but with Terraform. So, I’m going to modify the azure-cli docker image and
save it with the local instructions below, so I can just run it inside docker. I can choose to clear all state by
working from internal container storage, or mount a volume to save local state outside the container for reuse.

This should be run regularly to get the latest versions of azure-cli and terraform

## Create New Docker Azure CLI + Terraform Image

1. Deploy the latest azure-cli container

    ```bash
    docker run -it -v ${HOME}/.ssh:/root/.ssh -v ${HOME}/src:/root/src mcr.microsoft.com/azure-cli
    ```

1. Modify the azure-cli container

    This will initially just setup an alias and install Terraform.

    Eventually, we will need to add more steps here, including setting up Azure credentials, installing git, or more.

    ```bash
    echo "alias lsa='ls -lAF'" > /etc/profile.d/local.sh

    apk add terraform --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community

    exit
    ```

1. Get the container id

    ```bash
    docker ps -a
    ```

    Output

    ```bash
    CONTAINER ID   IMAGE                         COMMAND             CREATED        STATUS                     PORTS     NAMES
    41b4f7e0c64e   mcr.microsoft.com/azure-cli   "/bin/sh -c bash"   24 hours ago   Exited (0) 4 seconds ago             funny_wu
    ```

1. Save the modified container

    ```bash
    docker commit 41b4f7e0c64e azure-cli-terraform
    ```

    Output

    ```bash
    sha256:0c743f7bf48adf41f7e847aa0d5678b7c0f5c931ae73a6d66c9dea26d9cdbbd7
    ```

1. View Docker images

    ```bash
    docker images
    ```

    Output

    ```bash
    REPOSITORY                                                TAG                                                                          IMAGE ID       CREATED          SIZE
    azure-cli-terraform                                       latest                                                                       0c743f7bf48a   18 seconds ago   1.23GB
    ```

## Use New Docker Azure CLI + Terraform Image

1. Run the new Docker azure-cli-terraform Image

    Define Docker Volumes to use local macOS user SSH keys and source code. This allows use of VS Code Editor on the
    Mac transparently, as we only run the code inside the docker image.

    ```bash
    docker run -it -v ${HOME}/.ssh:/root/.ssh -v ${HOME}/src:/root/src azure-cli-terraform
    ```

1. Confirm Azure CLI and Terraform versions

    ```bash
    az --version
    terraform --version
    ```

1. Login to Azure

    These instructions are showing login to michael.crawford@neudesic.com, and use of the “Neudesic-MCrawford-Sandbox”
    free account subscription.

    When you run az login, because this is running inside a docker container, it can not automatically open a browser
    window. You must instead open https://microsoft.com/devicelogin in a browser and enter the code shown in the
    response to this command. If you have multiple Azure Tenants configured (as I do), you must select which account to
    use. I selected the Neudesic account, for the responses shown below.

    ```bash
    az login
    ```

    Output

    ```bash
    To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code FLRXSJJR3 to authenticate.

    [
      {
        "cloudName": "AzureCloud",
        "homeTenantId": "687f51c3-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "id": "43969857-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "isDefault": true,
        "managedByTenants": [],
        "name": "Neudesic-MCrawford-Sandbox",
        "state": "Enabled",
        "tenantId": "687f51c3-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "user": {
          "name": "Michael.Crawford@neudesic.com",
          "type": "user"
        }
      },
      {
        "cloudName": "AzureCloud",
        "homeTenantId": "4bc7b452-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "id": "11c8b374-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "isDefault": false,
        "managedByTenants": [
          {
            "tenantId": "2f4a9838-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
          }
        ],
        "name": "DevOps RoadShow",
        "state": "Enabled",
        "tenantId": "4bc7b452-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "user": {
          "name": "Michael.Crawford@neudesic.com",
          "type": "user"
        }
      }
    ]
    ```

1. List Subscriptions

    Use this command to show all subscriptions, as you'll need the subscription id in the next command to select which
    subscription to use, if you have multiple associated with your account.

    ```bash
    az account list
    ```

    Output

    ```bash
    [
      {
        "cloudName": "AzureCloud",
        "homeTenantId": "687f51c3-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "id": "43969857-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "isDefault": true,
        "managedByTenants": [],
        "name": "Neudesic-MCrawford-Sanbox",
        "state": "Enabled",
        "tenantId": "687f51c3-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "user": {
          "name": "Michael.Crawford@neudesic.com",
          "type": "user"
        }
      },
      {
        "cloudName": "AzureCloud",
        "homeTenantId": "4bc7b452-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "id": "11c8b374-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "isDefault": false,
        "managedByTenants": [
          {
            "tenantId": "2f4a9838-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
          }
        ],
        "name": "DevOps RoadShow",
        "state": "Enabled",
        "tenantId": "4bc7b452-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "user": {
          "name": "Michael.Crawford@neudesic.com",
          "type": "user"
        }
      }
    ]
    ```

1. Set the Subscription to use

    ```bash
    az account set --subscription="43969857-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
    ```


