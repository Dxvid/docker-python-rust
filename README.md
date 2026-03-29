# docker-python-rust
Docker image with Python and Rust

### Usage:

```docker
docker run -it \
    --mount type=bind,source="$(pwd)/path/to/your/sourcecode",target=/src \
    davidkronlid/python-rust:latest bash
```

### Usage: create new image based on this image with the requirements you have.

For example a Dockerfile similar to this:

```dockerfile
FROM davidkronlid/python-rust:latest

COPY requirements.txt /

RUN pip3 install --no-cache-dir --break-system-packages -r /requirements.txt

ENTRYPOINT ["bash"]
```

And then build it with:

```docker
docker build --pull .
```

