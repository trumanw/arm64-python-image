FROM arm64v8/centos:latest

# yum preparation
RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo
RUN yum makecache
RUN yum update -y

# Install Development Tools
RUN yum install wget -y
RUN yum groupinstall "Development Tools" -y
RUN yum install cmake -y

# Copy and install Miniconda
RUN mkdir -p /root/opt && cd /root/opt
RUN wget https://github.com/conda-forge/miniforge/releases/download/4.9.0-4/Miniforge3-4.9.0-4-Linux-aarch64.sh
RUN bash /root/opt/Miniforge3-4.9.0-4-Linux-aarch64.sh -b -p $HOME/miniforge
RUN $HOME/miniforge/bin/conda init bash

# Create conda environment for compilation
RUN conda create -y -d --name p37 python=3.7 \
    conda activate p37

CMD [ "/bin/bash" ]