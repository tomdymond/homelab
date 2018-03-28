FROM centos:7

RUN yum -y update
RUN yum -y install wget genisoimage epel-release createrepo syslinux
RUN yum -y install xorriso libstdc++ libstdc++.so.6 rsync

VOLUME ["/data"]

COPY entrypoint.sh /
COPY isolinux.cfg /
COPY grub.cfg /
COPY ks.cfg.SAMPLE /
COPY mk_chroot_hpacucli /usr/bin/mk_chroot_hpacucli
RUN chmod 0755 /entrypoint.sh /usr/bin/mk_chroot_hpacucli

ENTRYPOINT ["/entrypoint.sh"]

