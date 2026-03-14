FROM opensuse/tumbleweed:latest

# Uppdatera systemet och installera Python 3.13 + pip + rustup
RUN zypper --non-interactive --gpg-auto-import-keys refresh --force && \
    zypper --non-interactive dup --allow-vendor-change --auto-agree-with-licenses \
           --force-resolution --remove-orphaned && \
    zypper --non-interactive install --no-recommends\
        python3.13 \
        python3.13-pip \
        python3.13-wheel \
        python3.13-setuptools \
        rustup \
        gcc \
        gcc-c++ \
        make \
        ca-certificates && \
    zypper clean -a && \
    update-ca-certificates

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

# Initiera rustup och installera senaste stabila Rust
RUN rustup-init -y --default-toolchain stable

# Lägg till Rust i PATH
ENV PATH="/root/.cargo/bin:${PATH}"

# Verifiera installationer
RUN python3.13 --version && \
    pip3.13 --version && \
    rustc --version && \
    cargo --version

CMD ["/bin/bash"]
