FROM jupyter/all-spark-notebook
MAINTAINER Seth Paul

USER root

RUN apt-get update
RUN apt-get -y install git-all
RUN git clone https://github.com/jonathanrocher/pandas_tutorial.git /home/jovyan/Resources/SciPy_2015-2016_Pandas_tutorial
RUN git clone https://github.com/jvns/pandas-cookbook.git /home/jovyan/Resources/Pandas_Cookbook
RUN git clone https://github.com/SethPaul/Pandas_Intro.git /home/joyvan/Utah_Data_Science_Pandas_Intro

RUN wget http://sethcpaul.com/wp-content/uploads/2016/09/Pandas-DataFrame-Notes.pdf -P /home/jovyan/Resources/

USER $NB_USER

WORKDIR /home/jovyan/
