FROM hiracchi/ubuntu-ja
MAINTAINER Toshiyuki HIRANO <hiracchi@gmail.com>

# packages install
RUN apt-get update && apt-get install -y \
    squid3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i 's/#acl localnet src/acl localnet src/g' /etc/squid/squid.conf
RUN sed -i 's/#http_access allow localnet/http_access allow localnet/' /etc/squid/squid.conf
RUN sed -i 's/#cache_dir ufs \/var\/spool\/squid 100 16 256/cache_dir ufs \/var\/spool\/squid 100 16 256/' /etc/squid/squid.conf
RUN sed -i 's/# cache_effective_user proxy/cache_effective_user proxy/' /etc/squid/squid.conf
RUN mkdir -p /var/spool/squid && \
    chown proxy /var/spool/squid

ADD run_service.sh /root/run_service.sh
RUN chmod +x /root/run_service.sh

EXPOSE 3128
ENTRYPOINT /root/run_service.sh
