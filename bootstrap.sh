wget https://wsldownload.azureedge.net/Ubuntu_2004.2020.424.0_x64.appx -O image.appx
unzip -j image.appx install.tar.gz
docker import ./install.tar.gz wsl/ubuntu:focal
