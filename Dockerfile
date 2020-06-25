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
 gfortran \
 imagemagick \
 alien \
 parallel \ 
 gawk \ 
htop && rm -rf /var/lib/apt/lists/*

# Use the environment.yml to create the conda environment.
ADD environment.yml /tmp/environment.yml
WORKDIR /tmp
RUN conda env create -f environment.yml -n drylab


RUN apt-get update && apt-get install -y \
    vim && \
    useradd drylab && \
    echo 'source activate base' >> /root/.bashrc && \
    echo 'export PS1="\[\e[35;1m\]\W:\[\e[37;1m\]~λ \[\e[0m\]"' >> /root/.bashrc
ENV USER="drylab"




ENTRYPOINT ["/bin/bash", "-c"]
CMD ["/bin/bash"]
