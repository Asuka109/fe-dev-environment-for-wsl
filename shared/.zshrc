# OMZSH
export PATH=$PATH:~/.local/bin
export STARTUP=$HOME/.startup
source $STARTUP/zsh

# NVM
export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node
export NPM_CONFIG_REGISTRY=https://registry.npmmirror.com
export NVM_DIR="\$HOME/.nvm"
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Proxy
export HOST_IP=$(cat /etc/resolv.conf | grep "nameserver" | cut -f 2 -d " ")
export HOST_PROXY_PROTOCOL=http
export HOST_PROXY_PORT=4780
export HOST_PROXY_URL=$HOST_PROXY_PROTOCOL://$HOST_IP:$HOST_PROXY_PORT
alias setproxy="export all_proxy=$HOST_PROXY_URL"
alias unsetproxy="unset all_proxy"
alias ip="curl -s http://ip-api.com/json | jq"
alias checkproxy="curl -x $HOST_IP:$HOST_PROXY_PORT http://example.com 1>/dev/null 2>/dev/null"
checkproxy && setproxy