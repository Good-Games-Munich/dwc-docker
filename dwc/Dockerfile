FROM python:2.7-slim

ARG DWC_VERSION=2c65a9f6afe508e236c222bd1b8f26fd63621a91
ARG TWISTED_VERSION=16.0.0

# Install requirements
RUN apt-get update -y && \
    apt-get install -y git gcc && \
    pip install twisted==$TWISTED_VERSION.

# Clone and checkout specific version of the server
RUN git clone https://github.com/barronwaffles/dwc_network_server_emulator.git /dwc && \
    cd /dwc && \
    git checkout $DWC_VERSION

# Patch the server to use the correct database paths and listen on all interfaces
RUN cd /dwc && \
    sed -i "s/127.0.0.1/0.0.0.0/g" altwfc.cfg && \
    sed -i "s?gpcm.db?./data/gpcm.db?g" register_page.py && \
    sed -i "s?gpcm.db?./data/gpcm.db?g" admin_page_server.py && \
    sed -i "s?gpcm.db?./data/gpcm.db?g" gamespy/gs_database.py && \
    sed -i "s?storage.db?./data/storage.db?g" storage_server.py && \
    mkdir data

EXPOSE 8000 9000 9001 9003 9009 9998 27500 28910 29900 29901 29920 27900/udp 27901/udp

WORKDIR /dwc/

COPY entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

CMD python master_server.py
