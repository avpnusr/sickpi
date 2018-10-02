FROM alpine:latest
MAINTAINER avpnusr

ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm'

COPY ./start.sh /start.sh

RUN apk --update --no-cache add \
        git python tzdata unrar &&\
    git clone --depth 1 https://github.com/SickRage/SickRage.git /sickrage && \
    chmod u+x /start.sh && \
    rm -rf /tmp && \
    rm -rf /var/cache/apk/*


VOLUME ["/data", "/incoming", "/media"]

EXPOSE 8081

HEALTHCHECK --interval=60s --timeout=15s --start-period=120s \
            CMD wget -q -O - 'http://localhost:8081'

WORKDIR /sickrage

CMD ["/start.sh"]
