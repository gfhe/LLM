#!/bin/bash

pip3 install envd
docker login -u hgfkeep

framework="txtai"

envd build  --output type=image,name=docker.io/hgfkeep/dev:${framework},push=true