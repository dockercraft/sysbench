FROM dockercraft/mysql-client:15.1
MAINTAINER Daniel <daniel@topdevbox.com>

# How-To
 # Local Build: docker build -t sysbench .
 # Local Run: docker run -it --rm sysbench --version

RUN apk add --virtual .build-deps build-base automake autoconf libtool mariadb-dev --update \
  && wget https://github.com/akopytov/sysbench/archive/1.0.14.zip \
  && unzip 1.0.14.zip \
  && cd sysbench-1.0.14 \
  && ./autogen.sh \
  && ./configure --disable-shared \
  && make \
  && make install \
  && apk del .build-deps \
  && cd / \
  && rm -R /sysbench-1.0.14 \
  && apk add gcc mariadb-client-libs --update \
  && rm -rf /var/cache/apk/*

ENTRYPOINT ["sysbench"]
