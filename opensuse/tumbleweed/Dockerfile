FROM opensuse/tumbleweed:latest

# Update the operating system and install Python + Rust + opencl + build tools
RUN zypper --non-interactive --gpg-auto-import-keys refresh --force && \
    zypper --non-interactive dup --allow-vendor-change --auto-agree-with-licenses \
           --force-resolution --remove-orphaned && \
    zypper --non-interactive in --no-recommends \
        curl \
        python313 \
        python313-pip \
        python313-wheel \
        python313-setuptools \
        python313-devel \
        python313-setuptools-rust \
        gcc \
        gcc-c++ \
        make \
        unzip \
        autoconf \
        automake \
        libtool \
        findutils \
        gawk \
        diffutils \
        ocl-icd-devel \
        clinfo \
        && \
    zypper clean -a && \
    python3 --version && \
    pip3 --version && \
    rustc --version && \
    cargo --version && \
    clinfo | grep -i opencl

# If you need 1.95 instead of what's the default in python313-setuptools-rust
# RUN zypper in rustup && rustup default 1.95

# If you need to fetch files from a repo:
# RUN zypper in git-core

# If R is needed:
# RUN zypper in R-base gcc-fortran python313-rpy2

# Probably not needed:
# RUN zypper in ocl-icd # not in standard repo ocl-icd-devel is probably good enough or better
# RUN zypper --non-interactive install --no-recommends ca-certificates &&  update-ca-certificates

# To install pyopencl directly in this image instead of building on top of this one as base image:
# RUN pip3 install pyopencl --break-system-packages

CMD ["/bin/bash"]
