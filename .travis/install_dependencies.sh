#!/bin/bash

gem install --no-document \
    haml \
    mdl \
    puppet-lint \
    reek \
    rubocop \
    ruby-lint \
    sass \
    scss_lint \
    scss_lint_reporter_checkstyle \
    slim \
    sqlint \
    foodcritic

go get -u \
   github.com/kisielk/errcheck \
   github.com/mdempsky/unconvert \
   github.com/golang/lint/golint \
   honnef.co/go/tools/cmd/megacheck

sudo luarocks install luacheck

npm install --global \
    coffeelint \
    coffeescript \
    csslint \
    eslint \
    handlebars \
    js-yaml \
    jscs \
    jshint \
    jsonlint \
    less \
    markdownlint-cli \
    pug-cli \
    semistandard \
    standard \
    tslint \
    typescript

pip install \
    schema-salad \
    docutils \
    pylint \
    sphinx \
    proselint

curl https://sh.rustup.rs -sSf | sh -s -- -y

curl -sSL https://get.haskellstack.org/ | sh
