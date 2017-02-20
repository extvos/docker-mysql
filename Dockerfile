FROM extvos/centos
MAINTAINER  "Mingcai SHEN <archsh@gmail.com>"
ENV MYSQL_MAJOR 5.6
ENV MYSQL_VERSION 5.6.26

RUN rpm -Uvh http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm \
    && yum -y install mysql-community-server \
    && rm -rf /var/lib/mysql \
    && mkdir -p /var/lib/mysql

RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# comment out a few problematic configuration values
# RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/my.cnf
COPY packages/my.cnf /etc/my.cnf

VOLUME /var/lib/mysql

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]