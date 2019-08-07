#!/bin/sh

echo -e "https://mirrors.aliyun.com/alpine/v3.8/main/\nhttps://mirrors.aliyun.com/alpine/v3.8/community/" >/etc/apk/repositories

apk update
apk add --no-cache openjdk8-jre ca-certificates tzdata tini
rm -rf /var/cache/apk/*

ln -snf "/usr/share/zoneinfo/$TZ" /etc/localtime
echo "$TZ" >/etc/timezone

adduser -S -h /opt/nifi -u 999 nifi

exit 0
