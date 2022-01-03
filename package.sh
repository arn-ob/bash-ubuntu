#!/bin/bash

# How i workable this package
#
# wget <from gist raw file>
# chmod +x install-package-for-ubuntu-20-04.sh && ./install-package-for-ubuntu-20-04.sh

# Issue: 
# Getting Error while executing a .sh file: /bin/bash^M: bad interpreter
# sed -i -e 's/\r$//' ./ubuntu-20-04.sh

echo 'Select your install or upgrade software based on ubuntu 20.04';

while :
do
    echo $'\n';

    echo '0: Exit';
    echo '1: Update';
    echo '2: Upgrade';
    echo '3: Install Nginx';
    echo '4: Install Lets Encrypt';
    echo '5: Install Docker';
    echo '6: Install Node JS';
    echo '7: Install node global packages (Ex: pm2, express)';
    echo '8: Install kubernetes';
    
    echo $'\n';
    read -p 'Select your choice: ' selector;
    echo $'\n';
    
    case $selector in
        0)
            echo "Exit"
            break;
        ;;
        1)
            echo "sudo apt-get update";
            sudo apt-get update
            
            continue;
        ;;
        2)
            echo "sudo apt-get update"
            sudo apt-get upgrade
            
            continue;
        ;;
        3)
            echo "Installing Nginx"
            sudo apt update
            sudo apt install nginx
            sudo ufw app list
            sudo ufw allow 'Nginx HTTP'
            sudo ufw status
            sudo systemctl --no-pager status nginx
            
            echo;
            continue;
        ;;
        4)
            echo "Installing Lets Encrypt"
            sudo apt update
            sudo apt install certbot python3-certbot-nginx
            sudo nginx -t
            sudo systemctl reload nginx
            
            echo;
            continue;
        ;;
        5)
            echo "Installing Docker community edition"
            sudo apt update
            sudo apt install apt-transport-https ca-certificates curl software-properties-common
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
            sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
            apt-cache policy docker-ce
            sudo apt install docker-ce
            sudo systemctl --no-pager status docker
            
            echo;
            continue;
        ;;
        6)
            echo "Installing Node js"
            curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
            sudo bash nodesource_setup.sh
            sudo apt install nodejs
            node -v
            sudo rm -R nodesource_setup.sh
            
            echo;
            continue;
        ;;
        7)
            echo "Install node global packages (Ex: pm2, express)"
            echo ""
            
            echo "npm install"
            sudo npm install -g npm
            
            echo "pm2 install"
            sudo npm install -g pm2
            
            echo "yarn install"
            curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
            echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
            sudo apt update
            sudo apt install --no-install-recommends yarn
            yarn --version
            
            echo;
            continue;
        ;;
        8)
            echo "Install kubernetes"
            sudo apt update
            sudo apt install git -y
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
            brew install gcc

            echo;
            continue;
        ;;
        *)
            echo "Sorry, Try Again"
            continue;
        ;;
    esac
done