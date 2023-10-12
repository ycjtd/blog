#!/usr/bin/env sh

set -e

pnpm build

cd dist

git init 

git add -A

git commit -m 'deploy'

git push -f git@github.com:<ycjtd>/<ycjtd>.github.io.git master
# git push -f git@github.com:ycjtd/blog.git


cd ..

rm -rf  dist

cd -
