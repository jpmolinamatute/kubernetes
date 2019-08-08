FROM juanpa/juanpasworld:openjre

ENV MEM=128m

COPY install.sh /opt
ADD  --chown=999:999 nifi-1.9.2-bin.tar.gz /opt/nifi/
RUN /opt/install.sh movesrc
COPY --chown=999:999 postgresql-42.2.5.jar /opt/nifi/lib/
USER nifi
WORKDIR /opt/nifi
EXPOSE 8080 8443 10000

VOLUME /opt/nifi/logs \
    /opt/nifi/database_repository \
    /opt/nifi/flowfile_repository \
    /opt/nifi/content_repository \
    /opt/nifi/provenance_repository \
    /opt/nifi/state

ENTRYPOINT ["/opt/install.sh", "run"]
