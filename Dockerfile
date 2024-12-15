FROM python:2.7-slim

# Install system tools and headers needed for building Twisted
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python2.7-dev \
    libffi-dev \
    libssl-dev \
    wget \
    tmux \
    git && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip, setuptools, and wheel to versions supporting Python 2.7
RUN pip install --no-cache-dir --upgrade \
    "pip==20.3.4" \
    "setuptools==44.1.1" \
    "wheel==0.37.1"

# Install typing and incremental first
RUN pip install --no-cache-dir \
    "typing==3.7.4.3" \
    "incremental==17.5.0" \
    "zope.interface==4.7.1"

# Now install Twisted 19.10.0
RUN pip install --no-cache-dir "twisted==19.10.0"

# Clone p2pool
RUN git clone https://github.com/p2pool/p2pool.git /opt/p2pool
WORKDIR /opt/p2pool

# Fetch bitcoin core v0.13.1
RUN wget https://bitcoincore.org/bin/bitcoin-core-0.13.1/bitcoin-0.13.1-x86_64-linux-gnu.tar.gz
RUN tar xvf bitcoin-0.13.1-x86_64-linux-gnu.tar.gz

# Copy entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
