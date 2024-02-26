#!/bin/bash

LLM_FACTORY_VERSION=0.5.2

apt install -y python3-pip
pip install --upgrade pip
pip install envd

envd build --output type=image,name=docker.io/hgfkeep/vllm-factory:${LLM_FACTORY_VERSION}-dev,push=true --ec type=registry,ref=docker.io/hgfkeep/vllm-factory:cache-dev --ic type=registry,ref=docker.io/hgfkeep/vllm-factory:cache-dev
envd build -f :serve --output type=image,name=docker.io/hgfkeep/vllm-factory:${LLM_FACTORY_VERSION}-runtime,push=true --ec type=registry,ref=docker.io/hgfkeep/vllm-factory:cache-run --ic type=registry,ref=docker.io/hgfkeep/vllm-factory:cache-run
