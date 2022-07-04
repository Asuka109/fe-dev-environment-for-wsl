FROM wsl/ubuntu:focal
COPY shared/ /app/shared/
# Apt
RUN DEBIAN_FRONTEND=noninteractive dpkg -i /app/shared/ca-certificates_20211016~20.04.1_all.deb &&\
    mv /etc/apt/sources.list /etc/apt/sources.list.bak &&\
    mv /app/shared/sources.list /etc/apt/sources.list &&\
    apt update &&\
    apt install -y python3 wget curl zsh git net-tools jq cmake ffmpeg sudo &&\
    mkdir -p ~/.local/bin &&\
    ln -s /usr/bin/batcat ~/.local/bin/bat
# Register user
RUN useradd -m -s /usr/bin/bash docker &&\
    echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers &&\
    su docker
USER docker
CMD /home/docker
# Node.js
RUN git clone https://gitee.com/mirrors/nvm.git ~/.nvm &&\
    (cd ~/.nvm && git checkout v0.39.1)
# ZSH
RUN sudo chown -R docker /app/shared &&\
    curl https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh | bash &&\
    mkdir ~/.startup &&\
    mv ~/.zshrc ~/.startup/zsh &&\
    mv /app/shared/.zshrc ~/.zshrc &&\
    chsh -s $(which zsh) &&\
    zsh
# NPM
RUN nvm install 14 &&\
    nvm install 16 &&\
    nvm alias default 14 &&\
    nvm use 14 &&\
    npm i -g yarn pnpm nrm rimraf serve
# Cleanup
RUN rm -rf /app/shared