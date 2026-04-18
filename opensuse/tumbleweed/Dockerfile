FROM opensuse/tumbleweed:latest

# Update the operating system and install Python + Rust + opencl + build tools
RUN zypper --non-interactive --gpg-auto-import-keys refresh --force && \
    zypper --non-interactive dup --allow-vendor-change --auto-agree-with-licenses \
           --force-resolution --remove-orphaned && \
    zypper --non-interactive in --no-recommends \
        autoconf \
        automake \
        clinfo \
        cmake \
        curl \
        diffutils \
        findutils \
        gawk \
        gcc \
        gcc-c++ \
        gcc-fortran \
        git-core \
        gmp-devel \
        gzip \
        libffi-devel \
        libopenssl-devel \
        libsecp256k1-devel \
        libsodium-devel \
        libtool \
        make \
        ninja \
        ocl-icd-devel \
        opencl-headers \
        patchelf \
        pkg-config \
        python313 \
        python313-devel \
        python313-pip \
        python313-setuptools \
        python313-setuptools-rust \
        python313-wheel \
        tar \
        unzip \
        && \
    zypper clean -a && \
    python3 --version && \
    pip3 --version && \
    rustc --version && \
    cargo --version && \
    clinfo | grep -i opencl

# If you need 1.95 instead of what's the default in python313-setuptools-rust
# RUN zypper in rustup && rustup default 1.95

# If R is needed:
# RUN zypper in R-base python313-rpy2

# To install pyopencl directly in this image instead of building on top of this one as base image:
# RUN pip3 install pyopencl --break-system-packages
# Or create a requirement file:
# RUN pip3 install --no-cache-dir --break-system-packages -r /requirements.txt

CMD ["/bin/bash"]
