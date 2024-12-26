FROM golang:alpine

MAINTAINER wangyuanchen

RUN apk add --no-cache tini mariadb-client

ADD . /go/src/github.com/wangyuanchen/go-mysql-elasticsearch

RUN apk add --no-cache mariadb-client
RUN go env -w GOPROXY=https://goproxy.cn,direct
RUN cd /go/src/github.com/wangyuanchen/go-mysql-elasticsearch/ && \
    go build -o bin/go-mysql-elasticsearch ./cmd/go-mysql-elasticsearch && \
    cp -f ./bin/go-mysql-elasticsearch /go/bin/go-mysql-elasticsearch

ENTRYPOINT ["/sbin/tini","--","go-mysql-elasticsearch","-config=/go/src/github.com/wangyuanchen/go-mysql-elasticsearch/etc/river.toml"]
