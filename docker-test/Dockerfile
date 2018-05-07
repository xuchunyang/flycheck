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
            golang-go \
            jruby \
            lacheck \
            luarocks \
            perl \
            protobuf-compiler \
            puppet \
            racket \
            scala \
            systemd \
            texinfo \
            tidy \
            verilator \
            xmlstarlet \
            zsh

# Install GO tools
ENV GOPATH=/usr/local/go \
    PATH=$GOPATH/bin:$PATH
RUN go get \
       # github.com/golang/lint/golint \  # Fails with gcimporter/iimport.go:77: undefined: io.SeekCurrent
       github.com/kisielk/errcheck \
       github.com/mdempsky/unconvert \
       honnef.co/go/tools/cmd/megacheck

# Install Rust
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Cargo needs to update its index otherwise tests will timeout
# There's a `-Z offline` flag, but nightly only.
# See https://github.com/rust-lang/cargo/issues/4686
RUN cargo search

# Install nodejs
ENV NODE_VERSION=8.11.1
RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
    && tar xf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
    && rm "node-v$NODE_VERSION-linux-x64.tar.xz" \
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
