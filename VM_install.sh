# Run this script to transform an existing VM into a 42VM
# You should use Ubuntu 18.04 or Xubuntu 18.04
# You can adapt this script to match another distro, but remember
# that for peer-evaluations, you MUST use the official one or a VM
# based on (X)ubuntu 18.04 and with the required packages/setup

# Make sure USER variabe is set
[ -z "${USER}" ] && export USER=$(whoami)

# Install packages
sudo apt-get update
sudo apt-get install -y \
  as31                  \
  autoconf              \
  build-essential       \
  clang-9               \
  cmake                 \
  curl                  \
  docker-compose        \
  docker.io             \
  emacs                 \
  freeglut3             \
  g++                   \
  gcc                   \
  git                   \
  glmark2               \
  libbsd-dev            \
  libbz2-dev            \
  libffi-dev            \
  liblzma-dev           \
  libncurses5-dev       \
  libreadline-dev       \
  libsqlite3-dev        \
  libssl-dev            \
  libx11-dev            \
  libxext-dev           \
  libxml2-dev           \
  libxmlsec1-dev        \
  libxt-dev             \
  lldb                  \
  llvm                  \
  make                  \
  mysql-server          \
  nasm                  \
  nginx                 \
  php-cli               \
  php-curl              \
  php-gd                \
  php-intl              \
  php-json              \
  php-mbstring          \
  php-mysql             \
  php-pgsql             \
  php-xml               \
  php-zip               \
  postgresql            \
  python-pip            \
  python3-pip           \
  qemu-kvm              \
  redis                 \
  ruby                  \
  ruby-bundler          \
  ruby-dev              \
  sqlite3               \
  sudo                  \
  terminator            \
  valgrind              \
  vim                   \
  virtualbox            \
  virtualbox-dkms       \
  virtualbox-qt         \
  wget                  \
  x11proto-core-dev     \
  xz-utils              \
  zlib1g-dev            \
  zsh                   \

# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Install minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/

# Make docker usable without sudo
sudo usermod -aG docker $USER

# Install golang
sudo add-apt-repository ppa:/longsleep/golang-backports &&
sudo apt update &&
sudo apt install golang-go &&

# Install nodejs
wget -qO- https://deb.nodesource.com/setup_13.x | sudo -E bash - &&
sudo apt install -y nodejs &&

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh%

# Install norminette
git clone https://github.com/42Paris/norminette.git ~/.norminette/
cd ~/.norminette/
bundle
echo 'alias norminette="~/.norminette/norminette.rb"\n' >> ~/.zshrc

# Install 42header vim plugin
mkdir -p ~/.vim/plugin/
curl -o ~/.vim/plugin/stdheader.vim https://raw.githubusercontent.com/42Paris/42header/master/vim/stdheader.vim
echo "export USER='$USER'" >> ~/.zshrc
echo "export MAIL='$USER@student.42.fr'" >> ~/.zshrc

# Alias gcc to clang to reflect mac behavior
echo "alias clang='clang-9'" >> ~/.zshrc
echo "alias gcc='clang'" >> ~/.zshrc
