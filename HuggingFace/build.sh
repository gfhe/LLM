docker build . -t hgfkeep/llm:hf-cuda11.8-torch11.4
docker push hgfkeep/llm:hf-cuda11.8-torch11.4


docker build . -f Dockerfile_dev -t hgfkeep/llm:hf-cuda11.8-torch11.4-dev
docker push hgfkeep/llm:hf-cuda11.8-torch11.4-dev
