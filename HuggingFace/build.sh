docker build . -t hgfkeep/llama:hf_torch_chat
docker push hgfkeep/llama:hf_torch_chat

docker build . -f Dockerfile_dev -t hgfkeep/llama:hf_torch_cuda11.3
docker push hgfkeep/llama:hf_torch_cuda11.3