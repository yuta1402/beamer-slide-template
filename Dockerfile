FROM paperist/alpine-texlive-ja:latest

RUN apk add make
RUN apk add ghostscript

WORKDIR /workdir
CMD ["/bin/sh"]
