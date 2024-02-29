#!/bin/bash

versions=(cu118 cu121)
torch_version="2.1.2"

buildTorch() {
    local v=$1
    local d=$2
    local t=$3
    envd_func="torch_${d}_${v}"
    echo "build torch:${v}_$d, use envd function: $envd_func"
    envd build -f :$envd_func --output type=image,name=docker.io/hgfkeep/torch:${t}_${v}_${d},push=true --ec type=registry,ref=docker.io/hgfkeep/torch:${t}_${v}_${d}-cache --ic type=registry,ref=docker.io/hgfkeep/torch:${t}_${v}_${d}-cache
}

for v in "${versions[@]}"
do
  buildTorch $v dev $torch_version
  buildTorch $v runtime $torch_version
done