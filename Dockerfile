FROM alpine:3.5
MAINTAINER Toshiyuki HIRANO <hiracchi@gmail.com>

# packages install
RUN apk update \
  && apk add --no-cache openrc squid \
  && rm -rf /var/cache/apk/* \
  && sed -i 's/#rc_sys=""/rc_sys="lxc"/g' /etc/rc.conf \
  && echo 'rc_provide="loopback net"' >> /etc/rc.conf \
  && sed -i 's/^#\(rc_logger="YES"\)$/\1/' /etc/rc.conf \
  && sed -i '/tty/d' /etc/inittab \
  && sed -i 's/hostname $opts/# hostname $opts/g' /etc/init.d/hostname \
  && sed -i 's/mount -t tmpfs/# mount -t tmpfs/g' /lib/rc/sh/init.sh \
  && sed -i 's/cgroup_add_service /# cgroup_add_service /g' /lib/rc/sh/openrc-run.sh

# setup squid
COPY squid.conf /etc/squid/squid.conf
#RUN sed -i 's/#acl localnet src/acl localnet src/g' /etc/squid/squid.conf \
#  && sed -i 's/#http_access allow localnet/http_access allow localnet/' /etc/squid/squid.conf \
#  && sed -i 's/#cache_dir ufs \/var\/spool\/squid 100 16 256/cache_dir ufs \/var\/spool\/squid 100 16 256/' /etc/squid/squid.conf 

# prepare to run
COPY docker-entrypoint.sh /
EXPOSE 3128
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/squid -NCd1"]

