FROM extvos/alpine
MAINTAINER  "Mingcai SHEN <archsh@gmail.com>"
ENV MYSQL_MAJOR 5.6
ENV MYSQL_VERSION 5.6.26

RUN apk update  && apk add mysql mysql-client \
    && rm -rf /var/lib/mysql \
    && mkdir -p /var/lib/mysql

# comment out a few problematic configuration values
# RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/my.cnf
COPY packages/my.cnf /etc/my.cnf

VOLUME /var/lib/mysql

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]