#!/bin/sh
git clone https://github.com/ilkilab/agorakube-docs.git
cd agorakube-docs/www
mkdocs build --clean
aws s3 sync ./site/ s3://agorakube-docs/ --delete
