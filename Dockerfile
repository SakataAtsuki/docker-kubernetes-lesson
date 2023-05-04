# docker build --platform linux/amd64 -t weblog-db:v1.0.0 .
# docker run --platform linux/amd64 -d weblog-db:v1.0.0
# docker exec -it xxxx sh
FROM alpine:3.9

COPY docker-entrypoint.sh /usr/local/bin

RUN \
    adduser -g mongodb -DH -u 1000 mongodb; \
    apk --no-cache add mongodb=4.0.5-r0; \
    chmod +x /usr/local/bin/docker-entrypoint.sh; \
    mkdir -p /data/db; \
    chown -R mongodb:mongodb /data/db;

VOLUME /data/db

EXPOSE 27017

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "mongod" ]
