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

# FORTRAN Hack
RUN wget 'http://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/x86_64/RPMS.classic//libgfortran3-6.3.1-alt5.x86_64.rpm' && alien -i libgfortran3-6.3.1-alt5.x86_64.rpm
ENV LD_LIBRARY_PATH="/usr/lib64/"

#bedGraphBIgWig hack
RUN ln -s /opt/conda/lib/libssl.so.1.1 /usr/lib64/libssl.so.1.0.0
RUN ln -s /opt/conda/lib/libcrypto.so.1.1 /usr/lib64/libcrypto.so.1.0.0


ENTRYPOINT ["/bin/bash", "-c"]
CMD ["/bin/bash"]
