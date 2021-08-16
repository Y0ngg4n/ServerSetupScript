#!/bin/sh


def setupSudo():
    apt install sudo

def setupKopia():
    curl -s https://kopia.io/signing-key | sudo apt-key add -
    echo "deb http://packages.kopia.io/apt/ stable main" | sudo tee /etc/apt/sources.list.d/kopia.list
    sudo apt update
    sudo apt install kopia -y
    
def setupFail2Ban():
    sudo apt install fail2ban -y

def setupSnap():
    sudo apt update
    sudo apt install snapd -y
    sudo snap install core
    sudo snap refresh core

def setupCertbot():
    sudo snap install --classic certbot
    
def setupDocker():
    sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io

def setupDockerCompose():
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

def setupNginxBrotli():
    chmod +x nginxBrotli.sh
    ./nginxBrotli.sh 1.20.1
    cp nginxBrotli.sh /usr/local/sbin/mkbrotli
    cp nginxBrotliAptHook.txt /etc/apt/apt.conf.d/05nginxmodules
    cp aptHookWorkerScript.sh /usr/local/sbin/nginx-mod-preinstall
    chmod +x /usr/local/sbin/nginx-mod-preinstall
    chmod +x /usr/local/sbin/mkbrotli

    
    
setupSudo
setupKopia
setupFail2Ban
setupSnap
setupCertbot
setupDocker
setupDockerCompose
setupNginxBrotli
