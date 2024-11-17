FROM 4km3/dnsmasq:2.85-r2-alpine-3.14

COPY dnsmasq.conf /etc/

COPY entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

CMD dnsmasq -k