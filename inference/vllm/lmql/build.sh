docker buildx build . -f Dockerfile --build-arg base=hgfkeep/vllm:latest -t hgfkeep/vllm_lmql:latest
docker push hgfkeep/vllm_lmql:latest