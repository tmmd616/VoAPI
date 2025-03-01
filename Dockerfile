FROM golang:1.21 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o voapi .

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/voapi .
COPY data ./data
COPY logs ./logs

ENV SQL_DSN=""
ENV REDIS_CONN_STRING=""
ENV SESSION_SECRET=""
ENV TZ="Asia/Shanghai"

EXPOSE 3000

CMD ["./voapi", "--log-dir", "/app/logs"]
