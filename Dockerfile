FROM lachlanevenson/k8s-kubectl:v1.13.10
RUN apk add socat

ADD run.sh /run.sh

ENTRYPOINT ["/run.sh"]
CMD ["help"]
