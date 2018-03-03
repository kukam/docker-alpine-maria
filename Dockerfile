FROM alpine:latest
MAINTAINER kukam "kukam@freebox.cz"

RUN apk --no-cache add --update mysql mysql-client bash && \
    awk '{ print } $1 ~ /\[mysqld\]/ && c == 0 { c = 1; print "skip-host-cache\nskip-name-resolve\nlower_case_table_names=1"}' /etc/mysql/my.cnf > /tmp/my.cnf && \
    mv /tmp/my.cnf /etc/mysql/my.cnf && \
    rm -fr /var/cache/apk/*

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 7775
VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/entrypoint.sh"]
