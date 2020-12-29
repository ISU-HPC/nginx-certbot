# nginx-certbot

FROM nginx
ENV container docker

RUN apt update && \
    apt install -y iputils-ping python python-dev libffi6 libffi-dev libssl-dev curl build-essential cron && \
    curl -L 'https://bootstrap.pypa.io/get-pip.py' | python && \
    pip install -U cffi certbot && \
    apt remove --purge -y python-dev build-essential libffi-dev libssl-dev curl && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /var/log/letsencrypt
RUN ln -s /dev/stdout /var/log/letsencrypt/letsencrypt.log
RUN echo "0 */12 * * * root /usr/local/bin/certbot renew" >> /etc/crontab

CMD cron && nginx -g "daemon off;"
