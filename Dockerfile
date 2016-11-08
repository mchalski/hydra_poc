FROM golang:1.7

# creds for hydra management - root client
# allows to connect and set keys shared between hydra and the rest of the world
ENV FORCE_ROOT_CLIENT_CREDENTIALS 2993d234-d46c-4202-9dda-507d20ba1975:lDAkLGMdy>sSalZ=

ADD ./hydra /go/src/github.com/ory-am/hydra
WORKDIR /go/src/github.com/ory-am/hydra

RUN go get github.com/Masterminds/glide
RUN glide install
RUN go install github.com/ory-am/hydra

COPY crypto/* /etc/hydra/

ENTRYPOINT /go/bin/hydra host --skip-tls-verify

EXPOSE 4444
