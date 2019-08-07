FROM alpine:latest
ENV LANG=en_CA.UTF-8
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/jre
ENV PATH=$PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin
ENV TZ=America/Halifax

COPY install.sh /
RUN /install.sh install
