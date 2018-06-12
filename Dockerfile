FROM alpine

RUN apk add --no-cache libpng-dev \
                        tar \
                        make \
                        g++

ADD https://github.com/google/guetzli/archive/master.tar.gz /master.tar.gz

RUN tar -xzf /master.tar.gz -C  /

WORKDIR /guetzli-master

RUN make

FROM alpine
COPY --from=0  /guetzli-master/bin/Release/guetzli /bin/guetzli

RUN mkdir /data && \
    apk add --no-cache gcc \
                        libc-dev \
                        libpng-dev

WORKDIR /data

CMD ["/bin/sh"]
