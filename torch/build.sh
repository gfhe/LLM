#!/bin/bash

versions=(cu118 cu121)

buildTorch() {
    local v=$1
    local d=$2
    envd_func="torch_${d}_${v}"
    echo "build torch:${v}_$d, use envd function: $envd_func"
    envd build -f :$envd_func --output type=image,name=docker.io/hgfkeep/torch:${v}_$d,push=true --ec type=registry,ref=docker.io/hgfkeep/torch:${v}_$d-cache --ic type=registry,ref=docker.io/hgfkeep/torch:${v}_$d-cache
}

for v in "${versions[@]}"
do
  buildTorch $v dev
  buildTorch $v runtime
done