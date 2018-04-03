#!/bin/bash

# Install programs from APT

# - sourceline: 'deb http://master.dl.sourceforge.net/project/d-apt/ d-apt

# For GCC-6
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
# For GHC 8
sudo add-apt-repository ppa:hvr/ghc -y

# For clang-5
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
echo "deb http://apt.llvm.org/trusty/ llvm-toolchain-trusty-5.0 main" | sudo tee -a /etc/apt/sources.list > /dev/null

sudo apt-get -qq update
sudo apt-get install -y \
     asciidoc \
     asciidoctor \
     chicken-bin \
     clang-5.0 \
     coq \
     cppcheck \
     gcc-6 \
     g++-6 \
     ghc-8.2.2 \
     gfortran \
     gnat \
     jruby \
     racket \
     scala \
     perl \
     luarocks \
     tidy \
     protobuf-compiler \
     puppet \
     verilator \
     xmlstarlet \
     texinfo \
     systemd \
     lacheck \
     chktex \
     stow \
     zsh

# TODO: override default GCC on Travis
sudo ln -s /usr/bin/gcc-6 /usr/local/bin/gcc
sudo ln -s /usr/bin/clang-5.0 /usr/local/bin/clang
sudo ln -s /usr/bin/llc-5.0 /usr/local/bin/llc

if ! hash ghc 2>/dev/null; then
    echo export PATH=/opt/ghc/bin:'$PATH' >> ~/.profile
fi

     # dmd-compiler \

# Install programs from language-specific package managers
# gem install --no-document \
#     haml \
#     mdl \
#     puppet-lint \
#     reek \
#     rubocop \
#     ruby-lint \
#     sass \
#     scss_lint \
#     scss_lint_reporter_checkstyle \
#     slim \
#     sqlint \
#     foodcritic

# go get -u \
#    github.com/kisielk/errcheck \
#    github.com/mdempsky/unconvert \
#    github.com/golang/lint/golint \
#    honnef.co/go/tools/cmd/megacheck

sudo luarocks install luacheck

if ! hash npm 2>/dev/null; then
    wget https://nodejs.org/dist/v8.11.1/node-v8.11.1-linux-x64.tar.xz
    tar xf node-v8.11.1-linux-x64.tar.xz
    sudo stow --target /usr/local node-v8.11.1-linux-x64
fi

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

# Refresh any binaries added to local node bin/ folder
sudo stow --target /usr/local node-v8.11.1-linux-x64

# pip install \
#     schema-salad \
#     docutils \
#     pylint \
#     sphinx \
#     proselint

if ! hash rustup 2>/dev/null; then
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    echo export PATH=$HOME/.cargo/bin:'$PATH' >> ~/.profile
else
    rustup update
fi

if ! hash stack 2>/dev/null; then
    curl -sSL https://get.haskellstack.org/ | sh
    echo export PATH=$HOME/.local/bin:'$PATH' >> ~/.profile
    stack setup
else
    stack upgrade
fi

if ! hash hlint 2>/dev/null; then
    stack install hlint         # Takes forever and needs 4Gb of RAM...
fi

#     echo "Installing packages from CPAN..."
#     sudo cpanm Perl::Critic
#     sudo chmod -R a+rX /usr/share/perl5 /usr/lib/perl5

#     echo "Installing packages from PEAR..."
#     sudo pear install PHP_CodeSniffer
#     echo 'include_path=".:/usr/share/pear/"' | sudo tee /etc/php/conf.d/pear.ini
#     echo 'extension=iconv.so' | sudo tee /etc/php/conf.d/iconv.ini
#     sudo chmod -R a+rX /usr/share/pear/PHP /etc/php/conf.d

#     echo "Installing packages from CRAN..."
#     export R_LIBS_USER=~/R
#     cat <<-EOF > install-packages.R
#       dir.create(Sys.getenv("R_LIBS_USER"), showWarnings = FALSE, recursive = TRUE)
#       install.packages("lintr", Sys.getenv("R_LIBS_USER"), repos="http://cran.case.edu")
# EOF
#     R CMD BATCH install-packages.R

#     echo "Installing hadolint..."
#     if [ ! -d hadolint ]; then
#       git clone --depth=1 https://github.com/lukasmartinelli/hadolint
#     else
#       pushd hadolint
#       git pull
#       popd
#     fi
#     pushd hadolint
#     stack setup
#     stack install
#     popd
