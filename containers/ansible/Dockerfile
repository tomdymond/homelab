FROM centos:7

RUN yum -y update
RUN yum -y install ansible

VOLUME /ansible/playbooks

WORKDIR /ansible/playbooks


COPY entrypoint.sh /



RUN chmod 0755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
