#/bin/sh
apt-get update && apt-get install -y \
        git \
        vim \
        wget \
        nano \
        zip \
        libzip-dev \
        zlibc \
        zlib1g \
        libmemcached-dev \
        net-tools \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libaio1 \

curl -L https://raw.github.com/adrianharabula/php7-with-oci8/master/docker-php.conf -o /etc/apache2/conf-enabled/docker-php.conf
cd /tmp && curl -L https://raw.github.com/adrianharabula/php7-with-oci8/master/instantclient/19.3.0.0.0/instantclient-basiclite-linux.x64-19.3.0.0.0dbru.zip -O
cd /tmp && curl -L https://raw.github.com/adrianharabula/php7-with-oci8/master/instantclient/19.3.0.0.0/instantclient-sdk-linux.x64-19.3.0.0.0dbru.zip -O
cd /tmp && curl -L https://raw.github.com/adrianharabula/php7-with-oci8/master/instantclient/19.3.0.0.0/instantclient-sqlplus-linux.x64-19.3.0.0.0dbru.zip -O

unzip /tmp/instantclient-basiclite-linux.x64-19.3.0.0.0dbru.zip -d /usr/local/
unzip /tmp/instantclient-sdk-linux.x64-19.3.0.0.0dbru.zip -d /usr/local/
unzip /tmp/instantclient-sqlplus-linux.x64-19.3.0.0.0dbru.zip -d /usr/local/

ln -s /usr/local/instantclient_19_3 /usr/local/instantclient
ln -s /usr/local/instantclient/lib* /usr/lib
ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus

echo 'export LD_LIBRARY_PATH="/usr/local/instantclient"' >> /root/.bashrc
echo 'umask 002' >> /root/.bashrc

echo 'instantclient,/usr/local/instantclient' | pecl install oci8-2.2.0
echo "extension=oci8.so" > /usr/local/etc/php/conf.d/php-oci8.ini
