
FROM ubuntu:16.04
ENV container docker
# Don't start any optional services except for the few we need.
RUN find /etc/systemd/system \
         /lib/systemd/system \
         -path '*.wants/*' \
         -not -name '*journald*' \
         -not -name '*systemd-tmpfiles*' \
         -not -name '*systemd-user-sessions*' \
         -exec rm \{} \;

### Update and upgrade and install some other packages.
RUN apt-get update && \
    apt-get -y upgrade && \
		apt-get install git -y

RUN locale-gen en_GB.UTF-8 && update-locale LANG=en_GB.UTF-8


### Install packages required by tvb_library.
RUN apt-get install -y python2.7
RUN wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
RUN sudo mv Miniconda2-latest-Linux-x86_64.sh /opt/ && \
    sudo chmod 777 /opt/Miniconda2-latest-Linux-x86_64.sh && \
		sudo bash /opt/Miniconda2-latest-Linux-x86_64.sh && \
		conda install pip Cython numpy scipy

### Get tvb_library code from git.
RUN git clone --progress --verbose https://github.com/the-virtual-brain/tvb-library.git /usr/local/src/tvb_library
