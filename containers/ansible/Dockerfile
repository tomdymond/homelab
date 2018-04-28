FROM alpine:3.6

RUN apk --update add python py-pip openssl ca-certificates \
  && apk --update add --virtual build-dependencies python-dev libffi-dev openssl-dev build-base \
  && pip install --upgrade pip cffi \
  && pip install ansible \
  && apk del build-dependencies \
  && rm -rf /var/cache/apk/*

VOLUME /ansible/playbooks

WORKDIR /ansible/playbooks


COPY entrypoint.sh /



RUN chmod 0755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
