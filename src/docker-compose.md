## Docker Compose
What is Docker compose?
 - It's a way to automate the `docker run ...` commands. YOu can write everything needed in a file called `docker-compose.yaml` and with a single command the containers.
 - You can add multiple containers to a single `docker-compose.yaml` and they all can be started/stopped together
 - no need to remember long and complex `docker run ...` commands

## Installing Docker Compose
 - `docker-compose` can be installed with `apt`
    ```
    $ sudo apt install docker-compose
    ```
 - a new command called `docker-compose` should be available
> In newer versions of Docker, this step is not needed as docker compose is available with the docker installation. Debian smh.

## Using Docker Compose
 - To use docker-compose, we need to write a new file called `docker-compose.yaml` for our app
 - Go to the figlet-web repo we cloned earlier and open you favorite text editor
    ```
    $ cd -
    $ cd figlet-web
    $ nano docker-compose.yaml
    ```
 - Add these lines
    ```yaml
    version: "3"
    services:
      figlet_web:
      image: figlet-web:latest
      build: .
      ports:
       - 8081:8080
    ```
 - Build the image using docker-compose
    ```
    $ docker-compose build
    ```
 - Start the container
    ```
    $ docker-compose up
    ```
    > use `docker-compose up -d` if you want to continue using the terminal, or don't want the app to stop if you press `Ctr+C`. `-d` stands for detach. it tells docker compose to detach from the terminal and run in the background once the app has started.
 - Now the app should be running and should be accessible from the browser. goto `http://HOSTNAME_IN_CHIT.i10e.xyz:8081` to see it.
 - Again, we need to remove the :8081 at the end.
 - Update the Caddyfile, `/etc/caddy/Caddyfile` so it knows we want to see the new docker compose app instead.
    ```diff
    figlet-web-docker.HOSTNAME_IN_CHIT.i10e.xyz {
    -  reverse_proxy :8080
    +  reverse_proxy :8081
    }
    ```
    and reload Caddy with `sudo systemctl reload caddy.service`
 - Enjoy your app at `https://figlet-web-docker.HOSTNAME_IN_CHIT.i10e.xyz`
 - Stopping the container
    ```
    $ docker-compose down
    ```
