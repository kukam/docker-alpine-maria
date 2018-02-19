FROM alpine:latest
MAINTAINER kukam "kukam@freebox.cz"

RUN apk update && \
	apk --no-chage add --update mysql mysql-client bash && \
	addgroup mysql mysql && \
  awk '{ print } $1 ~ /\[mysqld\]/ && c == 0 { c = 1; print "skip-host-cache\nskip-name-resolve\nlower_case_table_names=1"}' /etc/mysql/my.cnf > /tmp/my.cnf  && \
  mv /tmp/my.cnf /etc/mysql/my.cnf 

VOLUME ["/var/lib/mysql"]

COPY ./startup.sh /startup.sh
RUN chmod +x /startup.sh

EXPOSE 3306

ENTRYPOINT ["/startup.sh"]
