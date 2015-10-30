FROM ubuntu:precise
MAINTAINER isqad88@yandex.ru

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

RUN mv /etc/localtime /etc/localtime-old
RUN ln -sf /usr/share/zoneinfo/Asia/Yekaterinburg /etc/localtime

RUN apt-get update -y && apt-get -y upgrade && \
    apt-get install -y --no-install-recommends nginx vim.tiny less sudo && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
    chown -R www-data:www-data /var/lib/nginx

RUN mkdir -p /files && chown -R www-data:www-data /files

ADD webdav /etc/nginx/sites-available/webdav
RUN rm /etc/nginx/sites-enabled/default && ln -sf /etc/nginx/sites-available/webdav /etc/nginx/sites-enabled/default

EXPOSE 80

CMD ["nginx"]
