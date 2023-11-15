#!/bin/bash
## 输入的数据： REPO_URL
## 环境默认带有 git huggingface_hub huggingface_cli curl wget
## 所有需要保留的数据存储到 /x 文件夹
REPO_URL=$1
DEST_PATH=/x
echo "repo url: $REPO_URL"

if [ -z "$REPO_URL" ]; then
  echo "REPO URL is EMPTY!!!!"
  exit -1
else
  echo "preparing data (REPO=$REPO_URL)..."
fi

repo_namespace=$(echo $REPO_URL|awk -F'/' '{print $(NF-1)}')
repo_name=$(echo $REPO_URL|awk -F'/' '{print $NF}')
repo_id="$repo_namespace/$repo_name"

# default clone model/datasets
##################################################
# git clone $REPO_URL $DEST_PATH

# custome process
# !!!!! comment default process first!!!!!!
# !!!!!!注释掉默认的处理过程!!!!!!
# 使用例子参考： get_hf/prepare-demo.sh
##################################################
huggingface-cli download $repo_id --exclude=*.bin --local-dir-use-symlinks=False --local-dir=$DEST_PATH
