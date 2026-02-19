# docker build -t art.local:8081/docker-local/lingro-docs:latest .
FROM art.local:8081/docker-release/node:24.13.1-alpine3.22 AS production

# 设置工作目录
WORKDIR /app

# 仅复制生产依赖
COPY package*.json ./
RUN npm ci --only=production --registry=https://registry.npmmirror.com && npm cache clean --force

# 复制构建产物
COPY . .

RUN npm run build

# 暴露端口
EXPOSE 3000

# 启动应用
CMD ["npx", "rspress", "preview", "--port", "3000", "--host", "0.0.0.0"]