FROM golang:1.23.2-alpine3.20 AS builder

WORKDIR /build

COPY . .

RUN go mod download

RUN go build -o jenkins_test ./main.go

FROM scratch

COPY --from=builder /build/jenkins_test /

ENTRYPOINT ["/jenkins_test"]