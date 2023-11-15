FROM nvcr.io/nvidia/pytorch:22.12-py3
LABEL MAINTAINER="heguangfu"
LABEL torch="1.14.0a0+410ce96"
LABEL cuda="11.8.89"
LABEL nvidia_driver="520.61.05"
LABEL base_env_instruction="https://docs.nvidia.com/deeplearning/frameworks/pytorch-release-notes/rel-22-12.html#rel-22-12"

ENV HUGGINGFACE_HUB_CACHE="/workspace/.cache/huggingface/hub"

WORKDIR /workspace

# 本地文件
COPY .bashrc /root/.bashrc
COPY requirements.txt /tmp/requirements.txt

# install python libs
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r /tmp/requirements.txt && \
    rm -rf /tmp/requirements.txt
