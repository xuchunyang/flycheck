# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://app.vagrantup.com/boxes/search

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 512
    vb.cpus = 2
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.

  # Install necessary packages not on Travis-CI
  config.vm.provision "basics",
                      type: "shell",
                      privileged: false,
                      inline: <<-SHELL
    sudo add-apt-repository ppa:kelleyk/emacs -y
    sudo apt-get update -qq
    sudo apt-get install -y \
         git \
         emacs25-nox

    if ! hash cask 2>/dev/null; then
      curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
      echo export PATH=$HOME/.cask/bin:'$PATH' >> ~/.profile
    else
      cask upgrade-cask
    fi
  SHELL

  # The additional packages needed to run the Flycheck integration tests
  config.vm.provision "flycheck-deps",
                      type: "shell",
                      privileged: false,
                      path: ".travis/install-dependencies.sh"

  # Add binaries from ad-hoc package managers to PATH
  # config.vm.provision "path-setup",
  #                     type: "shell",
  #                     privileged: false,
  #                     inline: <<-SHELL
  #   echo export PATH=$(ruby -e 'print Gem.user_dir')/bin:'$PATH' >> ~/.profile
  #   echo export PATH=$HOME/.node_modules/bin:'$PATH' >> ~/.profile
  #   echo export PATH=$HOME/go/bin:'$PATH' >> ~/.profile
  #   echo export PATH=$HOME/.local/bin:'$PATH' >> ~/.profile
  #   echo export R_LIBS_USER=$HOME/R >> ~/.profile
  # SHELL

end
