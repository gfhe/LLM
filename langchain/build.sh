#!/bin/bash

apt install -y python3-pip
pip install --upgrade pip
pip install envd

envd build --output type=image,name=docker.io/hgfkeep/langchain,push=true
