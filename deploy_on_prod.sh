#!/bin/bash

# 初始版本号变量
INITIAL_VERSION=$1
APP_NAME="lingro-doc"

# 如果没有传递初始版本号变量值
if [ -z "$INITIAL_VERSION" ]
then
  # 从远程镜像中心获取最新版本号
  LATEST_VERSION=$(docker images --filter reference=art.local:8081/docker-release/$APP_NAME --format "{{.Tag}}" | sort -V | tail -n 1)

  # 去掉版本号前的 'v' 字符
  LATEST_VERSION=${LATEST_VERSION#v}

  # 在最新版本号的修订号上加一
  INITIAL_VERSION=$(echo $LATEST_VERSION | awk -F. -v OFS=. '{$3++; if ($3 >= 1000) {$3 = 0; $2++}; if ($2 >= 1000) {$2 = 0; $1++}; print}')

  # 添加 'v' 前缀
  INITIAL_VERSION="v$INITIAL_VERSION"
fi

# 使用 docker tag 将最新的镜像打上新的版本号标签
docker tag art.local:8081/docker-local/$APP_NAME:latest art.local:8081/docker-release/$APP_NAME:$INITIAL_VERSION

# 将新的��像推送到远程镜像中心
docker push art.local:8081/docker-release/$APP_NAME:$INITIAL_VERSION

# 清理本地低于当前版本号的旧版本镜像
for tag in $(docker images --format "{{.Repository}}:{{.Tag}}" | grep "/docker-release/$APP_NAME:v" | grep -v "$INITIAL_VERSION"); do
  version=$(echo $tag | awk -F: '{print $NF}' | sed 's/v//')
  current=$(echo $INITIAL_VERSION | sed 's/v//')
  # 比较版本号
  if [ "$(printf '%s\n' "$version" "$current" | sort -V | head -n1)" = "$version" ] && [ "$version" != "$current" ]; then
    docker rmi "$tag"
  fi
done

git tag -a "$INITIAL_VERSION" -m "Release version $INITIAL_VERSION"

git push origin "$INITIAL_VERSION"