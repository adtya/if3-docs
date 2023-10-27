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
