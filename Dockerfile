FROM golang:1.21 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o voapi .

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/voapi .

# 创建 logs 目录 (如果需要)
RUN mkdir -p /app/logs
# 创建 data 目录 (如果需要)
RUN mkdir -p /app/data

# 如果 data 目录包含初始化数据，并且需要复制到镜像中，
# 确保 data 目录存在于你的 Git 仓库中，并且没有被 .gitignore 排除。
# COPY data ./data

ENV SQL_DSN=""
ENV REDIS_CONN_STRING=""
ENV SESSION_SECRET=""
ENV TZ="Asia/Shanghai"

EXPOSE 3000

CMD ["./voapi", "--log-dir", "/app/logs"]
