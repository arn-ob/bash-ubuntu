#!/bin/bash

echo 'Easy Manage For Ubuntu 20.04';

while :
do
    echo $'\n';
    echo '0: Exit';
    echo '1: Install domain';
    echo '2: Install package';
    
    echo $'\n';
    read -p 'Select your choice: ' selector;
    echo $'\n';

    case $selector in
        0)
            echo "Exit"
            break;
        ;;
        1)
            echo "bash domain";
            wget -c https://raw.githubusercontent.com/arn-ob/bash-exe-ubuntu-20-04/main/domain.sh && chmod 755 domain.sh && ./domain.sh
            continue;
        ;;
        2)
            echo "bash package";
            wget -c https://raw.githubusercontent.com/arn-ob/bash-exe-ubuntu-20-04/main/package.sh && chmod 755 package.sh && ./package.sh
            continue;
        ;;
    esac
done