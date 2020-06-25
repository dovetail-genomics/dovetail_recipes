# Hosted Miniconda based image
# Ubuntu 16.04
FROM continuumio/miniconda3
# System updates
RUN apt-get update && apt-get install -y \
 libssl-dev \
 libpq-dev \
 zlib1g-dev \
 build-essential \
 make \
 gcc \
 libpopt-dev \
 parallel \ 
 gawk \ 
 samtools \
 bwa \
 awscli \
htop && rm -rf /var/lib/apt/lists/*

# Use the environment.yml to create the conda environment.
#ADD environment.yml /tmp/environment.yml
#WORKDIR /tmp
#RUN conda env create -f environment.yml -n dovetail

RUN pip install scipy numpy cython jupyterlab cooler pairtools

#RUN apt-get update && apt-get install -y \
    #    vim && \
    #echo 'source activate base' >> /root/.bashrc && \
    # echo 'export PS1="\[\e[35;1m\]\W:\[\e[37;1m\]~λ \[\e[0m\]"' >> /root/.bashrc

ARG NB_USER=user_nb
ARG NB_UID=100
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    ${NB_USER}


ADD . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
WORKDIR ${HOME}

ENV SHELL /bin/bash
#CMD ["/bin/bash"]
