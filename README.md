# ARM64 Python Image

## Intuition

The image is used as the base image to compile or test python based scientific library or toolkits.

Base image: arm64v8/centos
Conda version: Miniforge3-Linux-aarch64

## Q&A

### 1. Standard_init_linux.go:211: exec user process caused "exec format error":

```
$ uname -m
x86_64

$ docker run --rm -t arm64v8/ubuntu uname -m
standard_init_linux.go:211: exec user process caused "exec format error"

$ docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

$ docker run --rm -t arm64v8/ubuntu uname -m
aarch64
```

For more details, please check [multiarch/qemu-user-static](https://github.com/multiarch/qemu-user-static).

### 2. Change YUM sources:

Change to Aliyun YUM source:
```
cd /etc/yum.repos.d
sudo wget -O CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo
yum makecache
yum update -y
```

### 3. Extension for PSI4 Dockerfile:

Append the lines below in the dockerfile:
```
# Install BLAS and LAPACK via conda
# conda install mkl-devel but not found for aarch
RUN conda install -y \
        blas \
        lapack \
        numpy \
        networkx \
        pint \
        msgpack-python \
        numpy
# Install pydantic via setup.py
RUN git clone -b 'v1.7.2' --single-branch --depth 1 https://github.com/samuelcolvin/pydantic.git
RUN cd pydantic && python setup.py install

# Start compile PSI4
RUN mkdir -p /opt/psi4/build \
    cd /opt/psi4
RUN MATH_ROOT=/root/miniforge/envs/p37/lib/ cmake -H. \
        -Bbuild \
        -DPYTHON_EXECUTABLE=/root/miniforge/envs/p37/bin/python
RUN cd build && make -j`getconf _NPROCESSORS_ONLN`
```

## Manifest
- opt: 
    All necessary softwares.
- setup-container.sh: 
    Setup a container named [arm64] for compiling.
- enter-container.sh:
    Enter the running container [arm64].
- remove-container.sh:
    Remove the running container [arm64].