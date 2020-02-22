# The Agorakube documentation website

Welcome to the Agorakube documentation !

This repository houses all of the assets required to build the Agorakube documentation website. We're glad that you want to contribute!

## How to contribute

We are really glad you're reading this, because we need volunteer developers to help this project come to fruition.

We want you working on things you're excited about.

You can contact us by mail agorakube@ilki.fr.

Or you can join Agorakube's community for discussion and ask questions : [Agorakube's Slack](http://slack.agorakube.ilkilabs.io/)

Channels :
- **#general** - For general purpose (news, events...)
- **#developpers** - For people who contribute to Agorakube by developing features
- **#end-users** - For end users who want to give us feedbacks
- **#random** - As its name suggests, for random discussions :)

## Set up a local test lab

You can, for exemple, set a local test lab for Agorakube-docs using Git and Docker.


1) SetUp the dev environment:
```
git clone https://github.com/ilkilab/agorakube-docs.git
docker run -d -p 80:80 --mount type=bind,source="$(pwd)"/agorakube-docs/www/,target=/var/site agorakube/test-agorakube-docs:v1
```
2) Open your Browser and go to http://[IP_DOCKER_NODE]

3) Edit files under ./agorakube-docs/www/. Website will be automatically updated.



