FROM python:3.7-alpine

# Install Build Dependencies...
RUN apk add --no-cache --virtual .build-deps \
    gcc \
    libffi-dev \
    musl-dev

# Install Swift and Keystone Python Packages...
RUN pip install --upgrade --no-cache-dir \
    pip \
    setuptools \
    python-swiftclient \
    python-keystoneclient

# Uninstall Build Dependencies...
RUN apk del .build-deps

# Add some fingerprint to the container...
COPY LICENSE README.md /

# Create Container's Entrypoint
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]