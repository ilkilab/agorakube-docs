FROM alpine
RUN apk update && apk add python && apk add --update py-pip && pip install mkdocs && pip install awscli && apk add git
WORKDIR /var/site/
