# tempnotebook
https://github.com/jupyter/tmpnb

## Prereqs
### docker
https://docs.docker.com/engine/installation/linux/ubuntulinux/

#### prereqs for docker: image-generic-extra-virtual
    sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual

    sudo reboot

    sudo apt-get update
    sudo apt-get install apt-transport-https ca-certificates
    sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

    echo 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' >> /etc/apt/sources.list.d/docker.list
<!--
    nano /etc/apt/sources.list.d/docker.list

add

      deb https://apt.dockerproject.org/repo ubuntu-xenial main

or

      deb https://apt.dockerproject.org/repo ubuntu-trusty main
 -->
then
    sudo apt-get update
    apt-cache policy docker-engine




#### install docker
    sudo apt-get update
    sudo apt-get install docker-engine
    sudo service docker start


## Get tempnb
     <!-- example of notebook pull -->
    docker pull jupyter/minimal-notebook
    export TOKEN=$( head -c 30 /dev/urandom | xxd -p )
    docker run --net=host -d -e CONFIGPROXY_AUTH_TOKEN=$TOKEN --name=proxy jupyter/configurable-http-proxy --default-target http://127.0.0.1:9999
    docker run --net=host -d -e CONFIGPROXY_AUTH_TOKEN=$TOKEN --name=tmpnb -v /var/run/docker.sock:/docker.sock jupyter/tmpnb


docker run -d \
    --net=host \
    -e CONFIGPROXY_AUTH_TOKEN=$TOKEN \
    -v /var/run/docker.sock:/docker.sock \
    jupyter/tmpnb \
    python orchestrate.py --image='jupyter/datascience-notebook' \
        --command='start-notebook.sh \
            "--NotebookApp.base_url={base_path} \
            --ip=0.0.0.0 \
            --port={port} \
            --NotebookApp.trust_xheaders=True"'


<!-- #./usr/local/bin/start-notebook.sh -->


<!-- docker run --net=host -d -e CONFIGPROXY_AUTH_TOKEN=$TOKEN \
           -v /var/run/docker.sock:/docker.sock \
           jupyter/tmpnb python orchestrate.py --image='jupyter/datascience-notebook' --command="jupyter notebook --NotebookApp.base_url={base_path} --ip=0.0.0.0 --port {port}" -->

### several command options available
--max-dock-workers 20
--host-directories /root/testeroni


## Should be up and running now
check {your_ip}:8000

## To stop and remove all containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)


## create new docker image

example:
dockerfile
    #
    # Super simple example of a Dockerfile
    #
    FROM ubuntu:latest
    MAINTAINER Andrew Odewahn "odewahn@oreilly.com"

    RUN apt-get update
    RUN apt-get install -y python python-pip wget
    RUN pip install Flask

    ADD hello.py /home/hello.py

    WORKDIR /home

UT data science container
wget http://sethcpaul.com/wp-content/uploads/2016/09/pandas_tutorial_dockerfile.txt

dockerfile
FROM jupyter/datascience-notebook
MAINTAINER Seth Paul

USER root

RUN apt-get update
RUN apt-get -y install git-all
RUN git clone https://github.com/jonathanrocher/pandas_tutorial.git /home/jovyan/SciPy_2015-2016_Pandas_tutorial
RUN git clone https://github.com/jvns/pandas-cookbook/tree/master/cookbook /home/jovyan/Pandas_Cookbook
RUN git clone https://github.com/jvns/pandas-cookbook/tree/master/cookbook /home/jovyan/Pandas_Cookbook

RUN wget http://sethcpaul.com/wp-content/uploads/2016/09/custom.js
RUN wget http://sethcpaul.com/wp-content/uploads/2016/09/custom.css
RUN wget https://docs.google.com/file/d/0ByIrJAE4KMTtS1ZmRldWSElRMmM/edit
RUN mv custom.css ~/.jupyter/custom/custom.css
RUN mv custom.js ~/.jupyter/custom/custom.js

USER $NB_USER

WORKDIR /home/jovyan/

docker build -t "utahds:dockerfile" .
docker run -it utahds:dockerfile /bin/bash

-e USER=$USER  -e USERID=$UID rocker/rstudio
docker run -d -P -v $(pwd):/home/$USER/foo \


docker build -t "simple_flask:dockerfile" .

docker tag {image id} {new_name}
, $(pwd):/home/$USER/foo

docker run --net=host -d -e CONFIGPROXY_AUTH_TOKEN=$TOKEN \
           -v /var/run/docker.sock:/docker.sock \
           jupyter/tmpnb python orchestrate.py --image='utahds:dockerfile' --command="jupyter notebook --NotebookApp.base_url={base_path} --ip=0.0.0.0 --port {port} --cull-timeout=10800 --max-dock-workers 10 --pool-size 20"


start script
https://www.digitalocean.com/community/tutorials/an-introduction-to-cloud-config-scripting


#cloud-config
package_upgrade: true
packages:
  - package_1
  - package_2
  - [package_3, version_num]


#cloud-config
package_update: true
package_upgrade: true
package_reboot_if_required: true
packages:
  - linux-image-extra-$(uname -r)
  - linux-image-extra-virtual
  - apt-transport-https
  - ca-certificates
  - docker.io
write_files:
  - path: /etc/apt/sources.list.d/docker.list
    content: |
      deb https://apt.dockerproject.org/repo ubuntu-xenial main
runcmd:
  - ln -sf /usr/bin/docker.io /usr/local/bin/docker
  <!-- - sed -i "$acomplete -F _docker docker" /etc/bash_completion.d/docker.io
  final_message: &quot;Your Docker server is now ready.&quot; -->

  - [apt-cache, policy, docker-engine]
  - [sudo, service, docker, start]
  - [export, TOKEN=$( head -c 30 /dev/urandom | xxd -p )]
  - [docker, run, --net=host, -d, -e, CONFIGPROXY_AUTH_TOKEN=$TOKEN, --name=proxy, jupyter/configurable-http-proxy, --default-target, http://127.0.0.1:9999]
  - [docker, run, --net=host, -d, -e, CONFIGPROXY_AUTH_TOKEN=$TOKEN, --name=tmpnb, -v, /var/run/docker.sock:/docker.sock jupyter/tmpnb]

  - [ sed, -i, -e, 's/here/there/g', some_file]
  - echo "modified some_file"
  - [cat, some_file]


  #cloud-config
  package_update: true
  package_upgrade: true
  packages:
    - apt-transport-https
    - ca-certificates
  write_files:
    - path: /etc/apt/sources.list.d/docker.list
      content: |
        deb https://apt.dockerproject.org/repo ubuntu-xenial main
  runcmd:
    - [apt-cache, policy, docker-engine]
    - [sudo, apt-get, install, docker-engine]


  runcmd:
    - [apt-cache, policy, docker-engine]
    - [sudo, service, docker, start]
    - [export, TOKEN=$( head -c 30 /dev/urandom | xxd -p )]
    - [docker, run, --net=host, -d, -e, CONFIGPROXY_AUTH_TOKEN=$TOKEN, --name=proxy, jupyter/configurable-http-proxy, --default-target, http://127.0.0.1:9999]
    - [docker, run, --net=host, -d, -e, CONFIGPROXY_AUTH_TOKEN=$TOKEN, --name=tmpnb, -v, /var/run/docker.sock:/docker.sock jupyter/tmpnb]

    - [ sed, -i, -e, 's/here/there/g', some_file]
    - echo "modified some_file"
    - [cat, some_file]



working{
  package_update: true
  package_upgrade: true
  packages:
    - linux-image-extra-$(uname -r)
    - linux-image-extra-virtual
    - apt-transport-https
    - ca-certificates
  write_files:
    - path: /etc/apt/sources.list.d/docker.list
      content: |
        deb https://apt.dockerproject.org/repo ubuntu-xenial main
  runcmd:
  }




# docker init
https://www.cloudsigma.com/how-to-run-docker-on-cloudsigma-with-cloudinit/
#cloud-config
package_upgrade: true
package_reboot_if_required: true
ssh_authorized_keys:
 - Your-Public-SSH-Key
packages:
 - docker.io
runcmd:
 - ln -sf /usr/bin/docker.io /usr/local/bin/docker
 - sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io
final_message: &quot;Your Docker server is now ready.&quot;

# getting jupyter hub up
<!-- Prerequisites:
 * Python
 * NodeJS/npm
 * pip

pip:
  apt install python-pip
  pip install --upgrade pip
node and npm:
  sudo apt-get install npm nodejs-legacy
jupyterHub:
  npm install -g configurable-http-proxy
  pip install jupyterhub


wget https://repo.continuum.io/archive/Anaconda2-4.1.1-Linux-x86_64.sh


Install Anaconda (installs most packages we'll want)
bash Anaconda2-4.1.1-Linux-x86_64.sh

#restart terminal

https://github.com/jupyter/jupyter/issues/71
# install everything (except JupyterHub itself) with Python 2 and 3. Jupyter is included in Anaconda.
conda create -n py3 python=3 anaconda
conda create -n py2 python=2 anaconda
# register py2 kernel
source activate py2
ipython kernel install
# same for py3, and install juptyerhub in the py3 env
source activate py3
ipython kernel install
pip install jupyterhub



sudo apt-get install python3-pip
pip3 install jupyterhub


SSL certificate
certbot

sudo apt-get install letsencrypt

letsencrypt certonly --webroot -w /var/www/example -d 138.68.62.63 -->
