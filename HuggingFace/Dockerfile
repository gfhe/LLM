FROM python:3.10
ENV HUGGINGFACE_HUB_CACHE="/workspace/.cache/huggingface/hub"
ENV MODEL_LLAMA="decapoda-research/llama-7b-hf"
WORKDIR /workspace
COPY requirements.txt /tmp/requirements.txt

RUN pip install --upgrade pip && \
    pip install -r /tmp/requirements.txt && \
    rm -rf /tmp/requirements.txt && \
    apt-get clean && rm -rf /var/lib/apt/lists/*. && \
    pip cache purge && \
    mkdir tools example && \
    wget -P tools https://raw.githubusercontent.com/huggingface/transformers/main/src/transformers/models/llama/convert_llama_weights_to_hf.py

COPY run.py /workspace/examples/start.py
# RUN python -c "from transformers import pipeline; print(pipeline('sentiment-analysis')('we love you'))"
