FROM golang:1.21-alpine AS builder
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o hodor .

FROM alpine:3.18
RUN apk add --no-cache tzdata curl

ENV TZ=UTC
COPY --from=builder /app/hodor /usr/local/bin/hodor

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
CMD ["hodor"]

