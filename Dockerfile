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
        make && \
    zypper clean -a

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

# Initiera rustup och installera senaste stabila Rust
# RUN rustup-init -y --default-toolchain stable
RUN rustup default 1.94

# Lägg till Rust i PATH
# ENV PATH="/root/.cargo/bin:${PATH}"

# Verifiera installationer
RUN python3.13 --version && \
    pip3.13 --version && \
    rustc --version && \
    cargo --version

CMD ["/bin/bash"]
