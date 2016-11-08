FROM golang:1.7

ADD ./hydra /go/src/github.com/ory-am/hydra
WORKDIR /go/src/github.com/ory-am/hydra

RUN go get github.com/Masterminds/glide
RUN glide install
RUN go install github.com/ory-am/hydra

COPY crypto/* /etc/hydra/

# gotcha: we need to import the keypair via the hydra CLI
# start hydra for a second, use the CLI, kill hydra, restart as entrypoint

ENTRYPOINT /go/bin/hydra host --skip-tls-verify

EXPOSE 4444
