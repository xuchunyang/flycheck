#!/bin/bash

# Install programs from APT

# - sourceline: 'deb http://master.dl.sourceforge.net/project/d-apt/ d-apt

sudo apt-get -qq update
sudo apt-get install -y \
     asciidoc \
     chicken-bin \
     coq \
     cppcheck \
     gfortran \
     gnat \
     groovy \
     hlint \
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
     zsh \
     llvm

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

# npm install --global \
#     coffeelint \
#     coffeescript \
#     csslint \
#     eslint \
#     handlebars \
#     js-yaml \
#     jscs \
#     jshint \
#     jsonlint \
#     less \
#     markdownlint-cli \
#     pug-cli \
#     semistandard \
#     standard \
#     tslint \
#     typescript

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

# curl -sSL https://get.haskellstack.org/ | sh
# stack setup


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
