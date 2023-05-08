FROM golang:alpine AS builder
ADD . /kafka-config-metrics
WORKDIR /kafka-config-metrics
RUN apk add git
RUN go build -o kcm-exporter . && cp kcm-exporter /kcm-exporter

FROM golang:alpine
COPY --from=builder /kcm-exporter /usr/bin/kcm-exporter
RUN mkdir /opt/kcm
COPY kcm.toml /opt/kcm/kcm.toml

EXPOSE 9899
CMD ["/usr/bin/kcm-exporter"]