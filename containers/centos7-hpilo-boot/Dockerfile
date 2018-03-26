FROM centos:7

RUN yum -y update
RUN yum -y install wget genisoimage epel-release createrepo
RUN yum -y install p7zip

VOLUME ["/data"]

COPY ks.cfg /
COPY entrypoint.sh /
COPY isolinux.cfg /
RUN chmod 0755 /entrypoint.sh


