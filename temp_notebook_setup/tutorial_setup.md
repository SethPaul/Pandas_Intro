# The Tutorial Setup is built using [Jupyter's tempnotebook template](https://github.com/jupyter/tmpnb)
and
the docker images provided at https://github.com/jupyter/docker-stacks
## Prereqs
Need to install docker if you do not use say DO's [one-click install and deploy docker](https://www.digitalocean.com/products/one-click-apps/docker/). If you use a one-click setup you can skip past the docker install portion.

#### Installing Docker
https://docs.docker.com/engine/installation/linux/ubuntulinux/

##### Prereqs for docker: image-generic-extra-virtual
For the repo addition below use the ubuntu version you are using, e.g. xenial or trusty
```bash
$ sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
$ sudo reboot
$ sudo apt-get update
$ sudo apt-get install apt-transport-https ca-certificates
$ sudo apt-key adv \
  --keyserver hkp://p80.pool.sks-keyservers.net:80 \
  --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo 'deb https://apt.dockerproject.org/repo ubuntu-<version> main' \
        >> /etc/apt/sources.list.d/docker.list
```
then
```bash
$ sudo apt-get update
$ apt-cache policy docker-engine
```

##### Get the docker engine
```bash
$ sudo apt-get update
$ sudo apt-get install docker-engine
$ sudo service docker start
```

## A simple example tempnb
Get a docker image, in this case the jupyter/minimal-notebook
```bash
$ docker pull jupyter/minimal-notebook
```
Create the random tokens used for naming the multiple Jupyter instances

      $ export TOKEN=$( head -c 30 /dev/urandom | xxd -p )
Start up the proxy

      $ docker run --net=host \
        -d -e CONFIGPROXY_AUTH_TOKEN=$TOKEN \
        --name=proxy jupyter/configurable-http-proxy \
        --default-target http://127.0.0.1:9999
Start up the docker notebook images

          $ docker run --net=host -d \
            -e CONFIGPROXY_AUTH_TOKEN=$TOKEN \
            --name=tmpnb \
            -v /var/run/docker.sock:/docker.sock jupyter/minimal-notebook


## Customized image
##### Docker file
We need to supply instructions to build the image. The instructions used for the tutorial image were:

        "dockerfile"
        FROM jupyter/all-spark-notebook
        MAINTAINER Seth Paul

        USER root

        RUN apt-get update
        RUN apt-get -y install git-all pip
        RUN git clone https://github.com/jonathanrocher/pandas_tutorial.git /home/jovyan/Resources/SciPy_2015-2016_Pandas_tutorial
        RUN git clone https://github.com/jvns/pandas-cookbook.git /home/jovyan/Resources/Pandas_Cookbook
        RUN git clone https://github.com/SethPaul/Pandas_Intro.git /home/jovyan/Utah_Data_Science_Pandas_Intro
        RUN pip install requests-futures

        RUN wget http://sethcpaul.com/wp-content/uploads/2016/09/Pandas-DataFrame-Notes.pdf -P /home/jovyan/Resources/

        USER $NB_USER

        WORKDIR /home/jovyan/

This gives the instructions used to build the image from the jupyter/all-spark-notebook as a base.

##### Building the image
      docker build -t "utahds:pandas_intro" .

##### Running the applications

        $ export TOKEN=$( head -c 30 /dev/urandom | xxd -p )
  Start up the proxy

        $ docker run --net=host \
    -d -e CONFIGPROXY_AUTH_TOKEN=$TOKEN \
    --name=proxy jupyter/configurable-http-proxy \
    --default-target http://127.0.0.1:9999
  Start up the new docker notebook image

      $  docker run -d \
      --net=host \
      -e CONFIGPROXY_AUTH_TOKEN=$TOKEN \
      -v /var/run/docker.sock:/docker.sock \
      jupyter/tmpnb \
      python orchestrate.py --image='utahds:dockerfile' \
          --command='start-notebook.sh \
              "--NotebookApp.base_url={base_path} \
              --ip=0.0.0.0 \
              --port={port} \
              --NotebookApp.trust_xheaders=True"'

##### Should be up and running now
check {your_ip}:8000

several command options available as seen at https://github.com/jupyter/tmpnb

## To stop and remove all containers
      $ docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)
