IMG=hgfkeep/pipserver:latest

docker build . -t $IMG
docker push $IMG
