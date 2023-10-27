## Installing Docker

 - Installing Docker with `apt`

    ```sh
    apt install docker.io
    ```

 - Verify the docker installation is working with
    ```sh
    sudo docker run hello-world
    ```
 - To use docker without sudo, add the non-root user (`if3`) to the `docker` group
    ```sh
    sudo gpasswd -a if3 docker
    ```
    > Note: Need to logout and log back into the VPS for this change to take effect

