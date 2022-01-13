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
    echo '3: Basic application install';
    echo '4: Install Nginx';
    echo '5: Install Lets Encrypt';
    echo '6: Install Docker';
    echo '7: Install Node JS';
    echo '8: Install node global packages (Ex: pm2, express)';
    echo '9: Install kubernetes';
    echo '10: Install Goolge chrome';
    echo '11: Install MongoDB';
    echo '12: Install Git';

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
            sudo apt autoremove
            sudo apt-get update
            
            continue;
        ;;
        2)
            echo "sudo apt-get update"
            sudo apt autoremove
            sudo apt-get upgrade
            
            continue;
        ;;
        3)
            echo "Basic application install"

            # Auto Remove
            sudo apt autoremove

            # curl
            sudo apt update
            sudo apt upgrade
            sudo apt install curl

            # yarn
            sudo apt install curl
            
            continue;
        ;;
        4)
            echo "Installing Nginx"
            
            sudo apt autoremove

            sudo apt update
            sudo apt install nginx
            sudo ufw app list
            sudo ufw allow 'Nginx HTTP'
            sudo ufw status
            sudo systemctl --no-pager status nginx
            
            echo;
            continue;
        ;;
        5)
            echo "Installing Lets Encrypt"

            sudo apt autoremove

            sudo apt update
            sudo apt install certbot python3-certbot-nginx
            sudo nginx -t
            sudo systemctl reload nginx
            
            echo;
            continue;
        ;;
        6)
            echo "Installing Docker community edition"

            sudo apt autoremove

            sudo apt update
            
            sudo apt install apt-transport-https ca-certificates curl software-properties-common
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
            sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
            
            apt-cache policy docker-ce
            
            sudo apt install docker-ce
            
            sudo systemctl --no-pager status docker
            sudo apt autoremove

            echo;
            continue;
        ;;
        7)
            echo "Installing Node js"

            sudo apt autoremove

            sudo apt update
            sudo apt install nodejs
            node -v

            # Read Version
            read -p 'Select your version(10-17): ' version; 
            
            curl -sL https://deb.nodesource.com/setup_$version.x -o nodesource_setup.sh
            sudo bash nodesource_setup.sh
            sudo apt install nodejs
            node -v

            # Remove Nodesource
            sudo rm -R nodesource_setup.sh
            
            # yarn
            sudo apt update
            sudo apt-get install yarn

            echo;
            continue;
        ;;
        8)
            echo "Install Node global packages (Ex: pm2, express)"
            echo ""
            
            sudo apt autoremove

            echo "npm install"
            sudo apt install npm

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
        9)
            echo "Install kubernetes"
            sudo apt update

            sudo apt install git -y
            
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
            brew install gcc

            echo;
            continue;
        ;;
        10)
            echo "Install Google Chrome"
            
            sudo apt update
            
            wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
            sudo dpkg -i google-chrome-stable_current_amd64.deb
            sudo apt -f install
            
            rm google-chrome-stable_current_amd64.deb
            sudo apt autoremove

            echo;
            continue;
        ;;
        11)
            echo "MongoDB install";
            sudo apt-get update

            wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -

            echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list

            sudo apt autoremove
            sudo apt-get update

            # install mongodb
            sudo apt-get install -y mongodb-org
            
            sudo apt autoremove

            continue;
        ;;
        12) 
            echo "Install git";

            sudo apt-get update;

            sudo apt install git

            sudo apt autoremove

            continue; 
        ;;
        *)
            echo "Sorry, Try Again"
            continue;
        ;;
    esac
done