#!/bin/bash

pip install --upgrade pip
pip install envd
envd build 
docker tag llm-factory:dev hgfkeep/vllm-factory:0.2-dev
docker push hgfkeep/vllm-factory:0.2-dev

envd build -f :serve
docker tag llm-factory:dev hgfkeep/vllm-factory:0.2-runtime
docker push hgfkeep/vllm-factory:0.2-runtime