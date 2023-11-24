# docker buildx build . -f Dockerfile --build-arg base=nvidia/cuda:12.2.2-cudnn8-devel-ubuntu22.04 -t hgfkeep/vllm:cudnn8-torch2.0.1-dev
# docker push hgfkeep/vllm:cudnn8-torch2.0.1-dev

# docker buildx build . -f Dockerfile --build-arg base=nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04 -t hgfkeep/vllm:cudnn8-torch2.0.1
# docker push hgfkeep/vllm:cudnn8-torch2.0.1

envd build --output type=image,name=docker.io/hgfkeep/vllm:cuda12.2.2-cudnn8-devel,push=true
envd build -f :serve --output type=image,name=docker.io/hgfkeep/vllm:cuda12.2.2-cudnn8-runtime,push=true
