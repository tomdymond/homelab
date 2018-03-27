FROM centos:7

RUN yum -y update
RUN yum -y install wget genisoimage epel-release createrepo
RUN yum -y install p7zip

VOLUME ["/data"]

COPY entrypoint.sh /
COPY isolinux.cfg /
COPY ks.cfg.SAMPLE /
COPY mk_chroot_hpacucli /usr/bin/mk_chroot_hpacucli
RUN chmod 0755 /entrypoint.sh /usr/bin/mk_chroot_hpacucli

