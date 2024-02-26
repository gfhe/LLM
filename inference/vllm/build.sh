#!/bin/bash

# docker buildx build . -f Dockerfile --build-arg base=nvidia/cuda:12.2.2-cudnn8-devel-ubuntu22.04 -t hgfkeep/vllm:cudnn8-torch2.0.1-dev
# docker push hgfkeep/vllm:cudnn8-torch2.0.1-dev

# docker buildx build . -f Dockerfile --build-arg base=nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04 -t hgfkeep/vllm:cudnn8-torch2.0.1
# docker push hgfkeep/vllm:cudnn8-torch2.0.1
# --export-cache type=registry,ref=hgfkeep/vllm:cache --import-cache type=registry,ref=hgfkeep/vllm:cache

pip install --upgrade pip
pip install envd


VLLM_VERSION=0.3.2
envd build --output type=image,name=docker.io/hgfkeep/vllm:${VLLM_VERSION}-dev,push=true --export-cache type=registry,ref=hgfkeep/vllm:cache --import-cache type=registry,ref=hgfkeep/vllm:cache
envd build -f :serve --output type=image,name=docker.io/hgfkeep/vllm:${VLLM_VERSION}-runtime,push=true --export-cache type=registry,ref=hgfkeep/vllm:cache-run --import-cache type=registry,ref=hgfkeep/vllm:cache-run
