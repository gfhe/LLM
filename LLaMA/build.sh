docker build . -f Dockerfile_dev -t hgfkeep/llm:hf-cuda11.8-torch11.4-dev-llama
docker push hgfkeep/llm:hf-cuda11.8-torch11.4-dev-llama

docker build . -f Dockerfile_dev_local -t hgfkeep/llm:hf-cuda11.8-torch11.4-dev-llama-zx
docker push hgfkeep/llm:hf-cuda11.8-torch11.4-dev-llama-zx