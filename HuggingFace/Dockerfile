FROM python:3.10

ENV HUGGINGFACE_HUB_CACHE="/workspace/.cache/huggingface/hub"
ENV MODEL_LLAMA="decapoda-research/llama-7b-hf"

WORKDIR /workspace
COPY requirements.txt /tmp/requirements.txt

# torch 使用了外部url， 单独安装
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r /tmp/requirements.txt && \
    rm -rf /tmp/requirements.txt && \
    pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 torchaudio==0.12.1 --extra-index-url https://download.pytorch.org/whl/cu113 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*. && \
    pip cache purge && \
    mkdir tools example && \
    wget -P tools https://raw.githubusercontent.com/huggingface/transformers/main/src/transformers/models/llama/convert_llama_weights_to_hf.py

COPY run.py /workspace/example/start.py
# RUN python -c "from transformers import pipeline; print(pipeline('sentiment-analysis')('we love you'))"
