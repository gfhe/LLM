FROM ubuntu:22.04 as builder
ARG REPO_URL=
RUN apt update && apt install -y git git-lfs
RUN echo "git clone url:${REPO_URL}"
RUN git clone $REPO_URL /x
RUN pwd

FROM busybox:latest as prod
ARG REPO_DIR=REPO
ARG REPO_URL=
LABEL MAINTAINER=hgfkeep

ENV REPO_DIR=${REPO_DIR}
ENV REPO_URL=${REPO_URL}

COPY --from=builder /x /${REPO_DIR}
CMD "cd /${REPO_DIR} && ls -al"
