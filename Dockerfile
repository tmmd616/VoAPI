FROM voapi/voapi:latest

# 可选：如果你需要在构建时执行任何操作，可以在这里添加
# 例如，复制配置文件：
# COPY ./config.json /app/config.json

# 设置工作目录（可选，如果需要）
WORKDIR /app

# 定义启动命令 (如果需要覆盖默认命令)
CMD ["--log-dir", "/app/logs"]

# 健康检查已经在基础镜像中定义，或者可以通过Render的Web UI配置
