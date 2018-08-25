FROM thenatives/ci-php72-yarn:1.0

RUN apt-get -y remove apache

RUN apt-get -y install nginx

WORKDIR /var/www/html
ADD ./src /var/www/html

EXPOSE 80
EXPOSE 9000