FROM hgfkeep/get_hf:latest as builder
ARG REPO_URL=

COPY get_hf/prepare.sh /prepare.sh
RUN bash /prepare.sh $REPO_URL

FROM busybox:latest as prod
ARG REPO_URL=
ARG REPO_DIR=REPO
LABEL MAINTAINER=hgfkeep

ENV REPO_URL=${REPO_URL}

COPY --from=builder /x /${REPO_DIR}
CMD "cd /${REPO_DIR} && ls -al && sleep 3600"
