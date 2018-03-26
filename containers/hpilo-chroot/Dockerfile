FROM centos:7

RUN yum -y update
RUN yum -y install wget

ADD https://downloads.hpe.com/pub/softlib2/software1/pubsw-linux/p1257348637/v77370/hpacucli-9.30-15.0.x86_64.rpm /tmp/
COPY mk_chroot_hpacucli /tmp/mk_chroot_hpacucli
RUN chmod 0755 /tmp/mk_chroot_hpacucli


VOLUME ["/data"]

WORKDIR /tmp
CMD ["./mk_chroot_hpacucli", "hpacucli-9.30-15.0.x86_64.rpm"]

