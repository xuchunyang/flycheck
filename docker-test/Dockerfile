FROM silex/emacs:25-dev

# Install tools that are in APT
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
            asciidoc \
            asciidoctor \
            chicken-bin \
            chktex \
            clang \
            coq \
            cppcheck \
            gfortran \
            ghc \
            gnat \
            lacheck \
            luarocks \
            perl \
            protobuf-compiler \
            puppet \
            python-pip \
            racket \
            ruby-dev \
            scala \
            systemd \
            texinfo \
            tidy \
            verilator \
            xmlstarlet \
            zsh

# Install Rust
ENV RUSTUP_HOME /usr/local/rustup
ENV CARGO_HOME /usr/local/cargo
ENV PATH=$CARGO_HOME/bin:$PATH
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Cargo needs to update its index otherwise tests will timeout
# There's a `-Z offline` flag, but nightly only.
# See https://github.com/rust-lang/cargo/issues/4686
RUN cargo search

# Install GO
ENV GOLANG_VERSION 1.10.2
RUN curl -Lo go.tgz "https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz" \
    && tar -C /usr/local -xf go.tgz \
    && rm go.tgz
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

# Install GO tools
RUN go get \
       github.com/golang/lint/golint \
       github.com/kisielk/errcheck \
       github.com/mdempsky/unconvert \
       honnef.co/go/tools/cmd/megacheck

# Install nodejs
ENV NODE_VERSION=8.11.1
RUN curl -Lo node.txz "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
    && tar -C /usr/local -xf node.txz --strip-components=1 --no-same-owner \
    && rm node.txz \
    && ln -s /usr/local/bin/node /usr/local/bin/nodejs

# Install NPM tools
RUN npm install --global \
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

# Install Python tools
RUN pip install -U pip setuptools
RUN pip install \
        docutils \
        flake8 \
        proselint \
        pylint \
        schema-salad \
        sphinx

# Install Ruby tools
RUN gem install --no-document \
        foodcritic \
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
        sqlint

# Install JRuby
ENV JRUBY_VERSION 9.1.17.0
RUN mkdir /opt/jruby \
  && curl -fSL https://s3.amazonaws.com/jruby.org/downloads/${JRUBY_VERSION}/jruby-bin-${JRUBY_VERSION}.tar.gz -o jruby.tgz \
  && tar -xz --strip-components=1 -f jruby.tgz -C /opt/jruby \
  && rm jruby.tgz
ENV PATH /opt/jruby/bin:$PATH

# TODO: check in `cask init` and `make init`?
# TODO: output versions of all tools at the end, for easy reference later on
