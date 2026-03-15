FROM opensuse/tumbleweed:latest

# Uppdatera systemet och installera Python 3.13 + pip + rustup
RUN zypper --non-interactive --gpg-auto-import-keys refresh --force && \
    zypper --non-interactive dup --allow-vendor-change --auto-agree-with-licenses \
           --force-resolution --remove-orphaned && \
    zypper --non-interactive install --no-recommends\
        python313 \
        python313-pip \
        python313-wheel \
        python313-setuptools \
        rustup \
        gcc \
        gcc-c++ \
        make \
        curl \
        unzip \
        autoconf \
        automake \
        libtool \
        findutils \
        gawk \
        diffutils \
        python313-devel && \
    zypper clean -a && \
    rustup default 1.94 && \
    python3 --version && \
    pip3 --version && \
    rustc --version && \
    cargo --version

# Behövs sannolikt inte:
# RUN zypper --non-interactive install --no-recommends ca-certificates && \
#    update-ca-certificates

# Ifall man behöver hämta från repo eller packa upp:
#        curl \
#        git-core \
#        tar \
#        gzip \

# Ifall R behövs:
# R-base
# gcc-fortran
# python3.13-devel
# python3.13-rpy2

CMD ["/bin/bash"]
