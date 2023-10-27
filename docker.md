## Docker?
 - `Docker` is a tool used for bundling together everything needed for a piece of code to run, into an `image`
 - It can later use this `image` to take care of running the code. It takes care of installing all dependencies, starting running it (and even making sure it keeps running)

### Why docker?
 - No more "it works on my machine" - because docker can create environments that are identical to the developer machine, so it always works :D
 - Share it with your friends - Create `images`, share it with your frends; now they can also self-host your work. yay!
 - No more messing up your system because of one wrong command and not knowing how to fix it. Just remove the container and make a new one

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

## Dockerfile

A Dockerfile is a file containing all the instructions needed to build an `image`

 - Create a file with the name `Dockerfile`
    ```sh
    nano Dockerfile
    ```
    and add these two lines to the file:
    ```Dockerfile
    FROM debian:12
    ENTRYTPOINT "echo" "Hello, World!"
    ```

 - An image can be built from this Dockerfile with the command

   `docker build <directory containing the Dockerfile> -t <tag>`

    ```sh
    docker build . -t if3-hello-world
    ```
    ```
    Sending build context to Docker daemon  5.632kB            
    Step 1/4 : FROM debian:12                                  
     ---> 676aedd4776f                                         
    Step 2/4 : RUN apt update                                  
     ---> Using cache                                          
     ---> d5d4d36443b4                                         
    Step 3/4 : RUN apt install figlet -y                       
     ---> Using cache                                          
     ---> 8f6773f5c1b8                                         
    Step 4/4 : ENTRYPOINT "figlet", "Hello, World!"               
     ---> Running in c6c1ac905894                              
    Removing intermediate container c6c1ac905894               
     ---> dcc0c73adb27                                         
    Successfully built dcc0c73adb27                            
    Successfully tagged if3-hello-world:latest
    ```

 - All available images can be seen using `docker image ls`
    ```
    $ docker image ls
    REPOSITORY        TAG       IMAGE ID       CREATED          SIZE
    if3-hello-world   latest    128a133d9ac4   11 minutes ago   117MB
    debian            12        676aedd4776f   2 weeks ago      117MB
    ```

 - A `container` can be created and started with `docker run ...`
    ```
    docker run if3-hello-world
    ```
    ```
    $ docker run if3-hello-world
     _   _      _ _         __        __         _     _ _ 
    | | | | ___| | | ___    \ \      / /__  _ __| | __| | |
    | |_| |/ _ \ | |/ _ \    \ \ /\ / / _ \| '__| |/ _` | |
    |  _  |  __/ | | (_) |    \ V  V / (_) | |  | | (_| |_|
    |_| |_|\___|_|_|\___( )    \_/\_/ \___/|_|  |_|\__,_(_)
                        |/
    ```
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