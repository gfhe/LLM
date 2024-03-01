#!/bin/bash

# docker buildx build . -f Dockerfile --build-arg base=nvidia/cuda:12.2.2-cudnn8-devel-ubuntu22.04 -t hgfkeep/vllm:cudnn8-torch2.0.1-dev
# docker push hgfkeep/vllm:cudnn8-torch2.0.1-dev

# docker buildx build . -f Dockerfile --build-arg base=nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04 -t hgfkeep/vllm:cudnn8-torch2.0.1
# docker push hgfkeep/vllm:cudnn8-torch2.0.1
# --export-cache type=registry,ref=hgfkeep/vllm:cache --import-cache type=registry,ref=hgfkeep/vllm:cache

docker login

VLLM_VERSION="0.3.2"
TORCH_VERSION="t2.1"
CUDA_VERSION="cu121"
PYTHRON_VERSION="py311"

envd build --output type=image,name=docker.io/hgfkeep/vllm:${VLLM_VERSION}-${PYTHRON_VERSION}-${TORCH_VERSION}-${CUDA_VERSION}-dev,push=true
envd build -f :serve --output type=image,name=docker.io/hgfkeep/vllm:${VLLM_VERSION}-${PYTHRON_VERSION}-${TORCH_VERSION}-${CUDA_VERSION}-runtime,push=true
