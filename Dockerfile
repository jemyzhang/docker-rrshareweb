FROM alpine:latest

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="jemyzhang"

ENV TZ=Asia/Shanghai
ENV PUID=1000
ENV PGID=1000

RUN addgroup -S rrshare -g $PGID && adduser -S rrshare -G rrshare -D -H -u $PUID

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache libstdc++ libc6-compat su-exec

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 3001 6714 30210
VOLUME /mnt /rrshare
ENTRYPOINT ["/entrypoint.sh"]
