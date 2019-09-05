FROM paperist/alpine-texlive-ja:latest

RUN apk add make

WORKDIR /workdir
CMD ["/bin/sh"]
