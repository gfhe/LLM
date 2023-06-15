IMG=hgfkeep/pipserver:hf_torch_11.3

docker build . -t $IMG
docker push $IMG
