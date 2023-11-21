FROM internetsystemsconsortium/bind9:9.18

WORKDIR /etc/bind

COPY configuration/named.conf.options ./
COPY configuration/named.conf.local ./
COPY configuration/zones/ ./zones/

COPY entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]