FROM debian:bookworm

RUN apt-get update -y && \
    apt-get install -y mariadb-server

COPY ./tools/mariadb.sh /usr/local/bin/mariadb.sh
RUN  chmod +x /usr/local/bin/mariadb.sh

ENTRYPOINT ["bash", "/usr/local/bin/mariadb.sh"]