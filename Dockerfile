FROM ubuntu:18.04
LABEL maintainer="aguiot--@student.42.fr"

# Set DEBIAN_FRONTEND to noninteractive during build only
ARG DEBIAN_FRONTEND=noninteractive

# Install base packages, trying to be the most similar as possible to a 42 session
RUN : \
 && apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y \
     autoconf          \
     as31              \
     build-essential   \
     clang-9           \
     cmake             \
     curl              \
     emacs             \
     freeglut3         \
     g++               \
     gcc               \
     git               \
     glmark2           \
     libbsd-dev        \
     libbz2-dev        \
     libffi-dev        \
     liblzma-dev       \
     libncurses5-dev   \
     libreadline-dev   \
     libsqlite3-dev    \
     libssl-dev        \
     libx11-dev        \
     libxext-dev       \
     libxml2-dev       \
     libxmlsec1-dev    \
     libxt-dev         \
     lldb              \
     llvm              \
     make              \
     nasm              \
     python-pip        \
     python3-pip       \
     ruby              \
     ruby-bundler      \
     ruby-dev          \
     sudo              \
     valgrind          \
     vim               \
     wget              \
     x11proto-core-dev \
     xz-utils          \
     zlib1g-dev        \
     zsh               \
 && rm -rf /var/lib/apt/lists/*

# Create user, with zsh shell and sudo rights with no password
ARG USER=user42
RUN : \
 && sh -c "useradd -m -s /bin/zsh $USER" \
 && sh -c "usermod -aG sudo $USER" \
 && sh -c "echo $USER:$USER | chpasswd" \
 && sh -c "echo '%sudo  ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"
USER user42
WORKDIR "/home/$USER/"

# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set MOTD
RUN echo '\necho "\n        :::      ::::::::\n      :+:      :+:    :+:\n    +:+ +:+         +:+  \n  +#+  +:+       +#+       \n+#+#+#+#+#+   +#+        \n     #+#    #+#          \n    ###   ########.fr    \n"\n' >> ~/.zshrc

# Install asdf-vm
RUN : \
 && git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8 \
 && echo "\n. $HOME/.asdf/asdf.sh\n" >> ~/.zshrc \
 && echo '\nasdfinstall() {\n        asdf plugin-add $1\n        asdf install $1 $2\n        asdf global $1 $2\n        asdf list\n}\n' >> ~/.zshrc \
 && curl https://raw.githubusercontent.com/asdf-vm/asdf-nodejs/master/bin/import-release-team-keyring | bash

# Install norminette
RUN : \
 && git clone https://github.com/42Paris/norminette.git ~/.norminette/ \
 && cd ~/.norminette/ \
 && bundle \
 && echo 'alias norminette="~/.norminette/norminette.rb"\n' >> ~/.zshrc

# Install 42header vim plugin
RUN : \
 && mkdir -p ~/.vim/plugin/ \
 && curl -o ~/.vim/plugin/stdheader.vim https://raw.githubusercontent.com/42Paris/42header/master/vim/stdheader.vim \
 && echo "export USER='$USER'" >> ~/.zshrc \
 && echo "export MAIL='$USER@student.42.fr'" >> ~/.zshrc

# Alias gcc to clang to reflect mac behavior
RUN : \
 && echo "alias clang='clang-9'" >> ~/.zshrc \
 && echo "alias gcc='clang'" >> ~/.zshrc

WORKDIR "/home/$USER/projects/"
ENTRYPOINT ["/bin/zsh"]
