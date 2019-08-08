#!/bin/sh

movesrc() {
    mv /opt/nifi/nifi-1.9.2/LICENSE /opt/nifi/nifi-1.9.2/NOTICE /opt/nifi/nifi-1.9.2/README /opt/nifi/nifi-1.9.2/bin /opt/nifi/nifi-1.9.2/conf /opt/nifi/nifi-1.9.2/docs /opt/nifi/nifi-1.9.2/extensions /opt/nifi/nifi-1.9.2/lib /opt/nifi
    mkdir -p /opt/nifi/content_repository /opt/nifi/database_repository /opt/nifi/flowfile_repository /opt/nifi/logs /opt/nifi/provenance_repository /opt/nifi/state /opt/nifi/work
    chown -R nifi /opt/nifi
}

run() {
    ulimit -n "$(ulimit -H -n)"
    # -Dorg.apache.nifi.bootstrap.config.pid.dir=/run/nifi
    exec "${JAVA_HOME}/bin/java" -cp "lib/bootstrap/*" "-Xms${MEM}" "-Xmx${MEM}" -Dorg.apache.nifi.bootstrap.config.log.dir=logs -Dorg.apache.nifi.bootstrap.config.file=conf/bootstrap.conf org.apache.nifi.bootstrap.RunNiFi run
}

$1

exit 0
