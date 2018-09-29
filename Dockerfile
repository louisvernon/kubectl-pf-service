FROM lachlanevenson/k8s-kubectl:v1.11.3

ADD run.sh /run.sh

ENTRYPOINT ["/run.sh"]
CMD ["help"]
