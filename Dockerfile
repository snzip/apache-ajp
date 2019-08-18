FROM ubuntu

MAINTAINER Song zipeng "snzipeng@gmail.com"


RUN apt-get update \
    && apt-get install -y --no-install-recommends apache2 \
                            libapache2-mod-jk

RUN a2enmod proxy
RUN a2enmod proxy_ajp

RUN a2enmod ssl
RUN a2enmod headers

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
# ENV APACHE_LOG_DIR /var/log/apache

ADD apache-selfsigned.crt /etc/ssl/certs/apache-selfsigned.crt
ADD apache-selfsigned.key  /etc/ssl/private/apache-selfsigned.key

ADD apache2.conf /etc/apache2/apache2.conf
ADD 000-default.conf /etc/apache2/sites-enabled/000-default.conf
ADD jk.conf /etc/apache2/mods-available/jk.conf
#COPY workers.properties /etc/libapache2-mod-jk/workers.properties



VOLUME ["/var/log/apache2"]
EXPOSE 80 443

COPY ./docker-entrypoint.sh /
RUN chmod u+x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]