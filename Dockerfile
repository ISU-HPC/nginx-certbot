# nginx-certbot

FROM nginx
ENV container docker

#RUN apt update && \
#    apt install -y iputils-ping python python-dev libffi6 libffi-dev libssl-dev curl build-essential cron && \
#    curl -L 'https://bootstrap.pypa.io/get-pip.py' | python && \
#    pip install -U cffi certbot && \
#    apt remove --purge -y python-dev build-essential libffi-dev libssl-dev curl && \
#    apt-get autoremove -y && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/*
#
RUN apt update
RUN apt -y install cron
RUN apt -y install python3 python3-venv libaugeas0 python3-pip
RUN apt -y install libffi6 libffi-dev libssl-dev curl build-essential
RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip
RUN pip3 install --upgrade cryptography cffi certbot certbot-nginx

RUN mkdir /var/log/letsencrypt
RUN ln -s /dev/stdout /var/log/letsencrypt/letsencrypt.log
RUN echo "0 */12 * * * root /usr/local/bin/certbot renew" >> /etc/crontab

CMD cron && nginx -g "daemon off;"



#sudo docker build --rm -t isuhpc/nginx-certbot:py3 .
#sudo docker run -ti  -v /tmp/$(mktemp -d):/run -d --rm -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 80:80 --name nginx-certbot isuhpc/nginx-certbot:py3
#sudo docker exec -ti  nginx-certbot bash

