FROM juanpa/juanpasworld:openjre

ENV MEM=128m

COPY install.sh /opt
ADD  --chown=999:999 http://apache.mirror.globo.tech/nifi/1.9.2/nifi-1.9.2-bin.tar.gz /opt/nifi/nifi-1.9.2-bin.tar.gz
RUN /opt/install.sh movesrc
COPY --chown=999:999 https://jdbc.postgresql.org/download/postgresql-42.2.5.jar /opt/nifi/lib/postgresql-42.2.5.jar
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
