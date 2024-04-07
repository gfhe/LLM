#!/bin/bash

pip3 install envd
docker login
tag="py311-cu12"
envd build -f :py --output type=image,name=docker.io/hgfkeep/py:${tag}

envd build -f :hf --output type=image,name=docker.io/hgfkeep/hf:${tag}