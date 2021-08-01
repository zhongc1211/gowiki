FROM golang:1.16-alpine AS builder

RUN apk update && apk add alpine-sdk git && rm -rf /var/cache/apk/*

RUN mkdir /app
WORKDIR /app
COPY . .

RUN go build wiki.go


FROM alpine:latest

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

RUN mkdir /app
WORKDIR /app

COPY --from=builder /app .

EXPOSE 8080


CMD ["/app/wiki"]