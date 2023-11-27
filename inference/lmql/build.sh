docker build --build-arg GPU_ENABLED=true -t hgfkeep/lmql:cuda11.8 .
docker push hgfkeep/lmql:cuda11.8

docker build --build-arg GPU_ENABLED=true -f Dockerfile.serve -t hgfkeep/lmql:cuda11.8-serve .
docker push hgfkeep/lmql:cuda11.8-serve


envd build --output type=image,name=docker.io/hgfkeep/lmql,push=true
