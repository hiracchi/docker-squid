FROM alpine:3.7
MAINTAINER Toshiyuki HIRANO <hiracchi@gmail.com>

# packages install
RUN apk update \
  && apk add --no-cache squid \
  && rm -rf /var/cache/apk/* 

# setup squid
COPY squid.conf /etc/squid/squid.conf

# prepare to run
COPY docker-entrypoint.sh /
EXPOSE 3128
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/squid -NCd1"]

