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
    CMD [ "gunicorn", "--bind", "0.0.0.0:8000", "webapp:app" ]
    ```
 - Building the image
    ```
    $ docker build . -t figlet-web
    Sending build context to Docker daemon  1.013MB            
    Step 1/5 : FROM python:3                                   
    ...
    ...
    Successfully built a96e88356d27
    Successfully tagged figlet-web:latest

    $ docker image ls
    REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
    figlet-web   latest    d0fbac841345   31 seconds ago   1.09GB
    python       3         17e65561fd2c   11 days ago      1.02GB
    ```
 - Now that the image is built, it can be ran with `docker run ...`
    ```
    $ docker run figlet-web
    [2023-10-27 13:56:39 +0000] [1] [INFO] Starting gunicorn 21.2.0
    [2023-10-27 13:56:39 +0000] [1] [INFO] Listening at: http://0.0.0.0:8000 (1)
    [2023-10-27 13:56:39 +0000] [1] [INFO] Using worker: sync
    [2023-10-27 13:56:39 +0000] [7] [INFO] Booting worker with pid: 7
    ```
 - Now the app should be running and should be accessible from the browser. goto `http://HOSTNAME_IN_CHIT.i10e.xyz:8000` to see it.
 - Not seeing anything? We need to tell docker that we are need to see what's on port 8000
    > `-p <host port>:<container port>` flag for the `docker run ...` command gives access to the `<container port>` from `<host port>` on the host.
    ```
    $ docker run -p 8000:8000 figlet-web
    ```
 - Try again by visiting `http://HOSTNAME_IN_CHIT.i10e.xyz:8000`
 - How to remove that ugly :8000 at the end?
 - Update the Caddyfile, `/etc/caddy/Caddyfile` so it knows where out docker python app is.
    ```
    figlet-web.HOSTNAME_IN_CHIT.i10e.xyz {
      reverse_proxy :8000
    }
    ```
    and reload Caddy with `sudo systemctl reload caddy.service`
 - Enjoy your app at `https://figlet-web.HOSTNAME_IN_CHIT.i10e.xyz`