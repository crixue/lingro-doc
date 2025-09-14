#!/usr/bin/bash

# 初始版本号变量
TAG_VERSION=$1
APP_NAME="lingro-doc"

git pull

#docker build --no-cache -t art.local:8081/docker-local/$APP_NAME:latest .
docker build -t art.local:8081/docker-local/$APP_NAME:latest .

docker push art.local:8081/docker-local/$APP_NAME:latest

if [ -n "$TAG_VERSION" ]; then
  docker tag art.local:8081/docker-local/$APP_NAME:latest art.local:8081/docker-local/$APP_NAME:$TAG_VERSION
  docker push art.local:8081/docker-local/$APP_NAME:$TAG_VERSION

  # 清理本地低于当前TAG_VERSION的旧版本镜像
  for tag in $(docker images --format "{{.Repository}}:{{.Tag}}" | grep "docker-local/$APP_NAME:v" | grep -v "$TAG_VERSION"); do
    version=$(echo $tag | awk -F: '{print $NF}' | sed 's/v//')
    current=$(echo $TAG_VERSION | sed 's/v//')
    # 比较版本号
    if [ "$(printf '%s\n' "$version" "$current" | sort -V | head -n1)" = "$version" ] && [ "$version" != "$current" ]; then
      docker rmi "$tag"
    fi
  done
fi
