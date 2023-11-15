#!/bin/bash

pip3 install envd
envd build
docker tag get_hf:dev hgfkeep/get_hf:dev
docker push hgfkeep/get_hf:dev


envd build -f :runtime
docker tag get_hf:dev hgfkeep/get_hf:latest
docker push hgfkeep/get_hf:latest