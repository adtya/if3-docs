## A Python web app with Docker
 - clone the `figlet-web` repository
    ```
    $ cd -
    $ git clone https://github.com/anandology/figlet-web
    ```
 - Writing a Dockerfile
    ```
    $ cd figlet-web
    $ nano Dockerfile
    ```
    Dockerfile:
    ```Dockerfile
    FROM python:3
    WORKDIR /app
    RUN apt update
    RUN apt install figlet -y
    COPY . .
    RUN pip install -r requirements.txt
    CMD [ "gunicorn", "--bind", "0.0.0.0:8080", "webapp:app" ]
    ```
 - Building the image
    ```
    $ docker build . -t figlet-web
 
    $ docker image ls
    REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
    figlet-web   latest    d0fbac841345   31 seconds ago   1.09GB
    python       3         17e65561fd2c   11 days ago      1.02GB
    ```
 - Now that the image is built, it can be ran with `docker run ...`
    ```
    $ docker run figlet-web
    ```
 - Now the app should be running and should be accessible from the browser. goto `http://HOSTNAME_IN_CHIT.i10e.xyz:8080` to see it.
 - Not seeing anything? We need to ask docker to  let us see what's on port 8080
    > `-p <host port>:<container port>` flag for the `docker run ...` command gives access to the `<container port>` from `<host port>` on the host.
    ```
    $ docker run -p 8080:8080 figlet-web
    ```
 - Try again by visiting `http://HOSTNAME_IN_CHIT.i10e.xyz:8080`
 - How to remove that ugly :8000 at the end? For that, we have to tell caddy to do its magic
 - Update the Caddyfile, `/etc/caddy/Caddyfile` so it knows where out docker python app is.
    ```diff
    +figlet-web-docker.HOSTNAME_IN_CHIT.i10e.xyz {
    +  reverse_proxy :8080
    +}
    ```
    and reload Caddy with `sudo systemctl reload caddy.service`
 - Enjoy your app at `https://figlet-web-docker.HOSTNAME_IN_CHIT.i10e.xyz`
