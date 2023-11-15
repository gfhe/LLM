docker buildx build . -f Dockerfile --build-arg base=nvidia/cuda:12.2.2-cudnn8-devel-ubuntu22.04 -t hgfkeep/vllm:cudnn8-torch2.0.1-dev
docker push hgfkeep/vllm:cudnn8-torch2.0.1-dev

docker buildx build . -f Dockerfile --build-arg base=nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04 -t hgfkeep/vllm:cudnn8-torch2.0.1
docker push hgfkeep/vllm:cudnn8-torch2.0.1
