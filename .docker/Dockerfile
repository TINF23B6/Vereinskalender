FROM php:8.2-apache

COPY ./.docker/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/mycert.key -out /etc/ssl/certs/mycert.crt -subj "/C=DE/ST=BW/L=Karlsruhe/O=TINF23B6/OU=WWW/CN=localhost"

RUN a2enmod rewrite && a2enmod ssl && a2enmod socache_shmcb
RUN sed -i '/SSLCertificateFile.*snakeoil\.pem/c\SSLCertificateFile \/etc\/ssl\/certs\/mycert.crt' /etc/apache2/sites-available/default-ssl.conf && sed -i '/SSLCertificateKeyFile.*snakeoil\.key/cSSLCertificateKeyFile /etc/ssl/private/mycert.key\' /etc/apache2/sites-available/default-ssl.conf
RUN a2ensite default-ssl

WORKDIR /var/www/html

RUN apt update && apt install libxslt1.1 libxslt1-dev -y

RUN docker-php-ext-install xsl mysqli

COPY . .

RUN chmod -R 777 /var/www/html

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]