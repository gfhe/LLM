docker build . -f Dockerfile_runtime -t hgfkeep/llamacpp:hf-cuda11.8-torch11.4
docker push hgfkeep/llamacpp:hf-cuda11.8-torch11.4

docker build . -f Dockerfile_dev -t hgfkeep/llamacpp:hf-cuda11.8-torch11.4-dev
docker push hgfkeep/llamacpp:hf-cuda11.8-torch11.4-dev
