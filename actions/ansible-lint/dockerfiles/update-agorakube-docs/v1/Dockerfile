FROM alpine
RUN apk update && apk add python && apk add --update py-pip && pip install mkdocs && pip install awscli
WORKDIR /var/site/
