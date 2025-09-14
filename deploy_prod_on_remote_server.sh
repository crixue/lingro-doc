#!/bin/bash

# 用法: ./deploy_prod_on_remote_server.sh <tag>
APP_NAME="lingro-doc"
CONTAINER_NAME="$APP_NAME"
PORT=25676

DEPLOY_TAG=$1
if [ -z "$DEPLOY_TAG" ]; then
  echo "No DEPLOY_TAG: $0 <tag> provided!"
  exit 1
fi

IMAGE="art.local:8081/docker-release/$APP_NAME:$DEPLOY_TAG"

echo "开始部署 $APP_NAME:$DEPLOY_TAG 到端口 $PORT"

# 1. 检查并停止旧容器
EXISTING_CONTAINER=$(docker ps -q -f name=$CONTAINER_NAME)
if [ -n "$EXISTING_CONTAINER" ]; then
  echo "停止旧容器: $CONTAINER_NAME"
  docker stop $CONTAINER_NAME
fi

# 2. 删除旧容器（如果存在）
EXISTING_CONTAINER=$(docker ps -aq -f name=$CONTAINER_NAME)
if [ -n "$EXISTING_CONTAINER" ]; then
  echo "删除旧容器: $CONTAINER_NAME"
  docker rm $CONTAINER_NAME
fi

# 3. 拉取新版本镜像
echo "拉取新镜像: $IMAGE"
docker pull $IMAGE

# 4. 运行新版本容器
echo "启动新容器: $CONTAINER_NAME"
docker run -d \
  --name $CONTAINER_NAME \
  --restart always \
  --cpus="0.3" \
  --memory="500m" \
  -v /etc/localtime:/etc/localtime:ro \
  -p $PORT:3000 \
  $IMAGE

# 5. 等待容器启动并验证
echo "等待容器启动..."
sleep 5

# 6. 检查容器是否正常运行
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
  echo "部署成功！新版本 $DEPLOY_TAG 已成功部署，运行在端口 $PORT"
else
  echo "错误：容器未能正常启动"
  docker logs $CONTAINER_NAME
  exit 1
fi

# 7. 清理旧版本镜像
echo "清理旧版本镜像..."
for tag in $(docker images --format "{{.Repository}}:{{.Tag}}" | grep "/docker-release/$APP_NAME:" | grep -v "$DEPLOY_TAG"); do
  echo "删除旧镜像: $tag"
  docker rmi "$tag" || true
done

echo "部署完成！"
