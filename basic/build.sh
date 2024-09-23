#!/bin/bash

pip3 install envd
docker login -u hgfkeep
basic="py311"
tag="py311-cu12"

# py37
envd build -f :py37 --output type=image,name=docker.io/hgfkeep/py:37,push=true

# #py311
envd build -f :py --output type=image,name=docker.io/hgfkeep/py:${basic},push=true

# hf
envd build -f :hf --output type=image,name=docker.io/hgfkeep/hf:${tag},push=true

