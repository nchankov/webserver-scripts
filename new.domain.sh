#!/bin/bash

while true; do
    if [ -z $1 ]; then
        read -e -p "What is the domain: " domain
    else
        domain=$1
    fi
    #break the loop once there is a valid directory provided
    if [ ! -z $domain ]; then
        break
    fi
done


if [ -z $2 ]; then
    #read available versions from ./resources/php
    echo ""
    echo '##### available versions #######'
    for file in ./resources/php/*
    do
        echo "$(basename -- ${file%.*})"
    done
    echo '##### available versions #######'
    echo ""
    echo "What PHP Version do you need. type the version of leave empty for default php"
    read -e -p "PHP Version: " php_version
else
    php_version=$2
fi

#where to place files (usually this is /etc/apache/sites-available)
AVAILABLE_LOCATION="/etc/apache2/sites-available"
ENABLED_LOCATION="/etc/apache2/sites-enabled"
WEB_LOCATION="/var/www"

if [ -f $AVAILABLE_LOCATION/$domain.conf ]; then
    echo "============================================================================"
    echo "!!!! The domain already exists !!!!"
    echo "View file $AVAILABLE_LOCATION/$domain.conf"
    echo "============================================================================"
    exit
fi

#create virtualhost file
cp ./resources/virtualhost.conf $AVAILABLE_LOCATION/$domain.conf
sed -i "s/domain.com/$domain/g" $AVAILABLE_LOCATION/$domain.conf

#replace php version if found the requested one
if [ -f ./resources/php/$php_version.conf ];then
    line=$(grep -n '##php_version##' $AVAILABLE_LOCATION/$domain.conf | cut -d ":" -f 1)
    { 
        head -n $(($line-1)) $AVAILABLE_LOCATION/$domain.conf; 
        cat ./resources/php/$php_version.conf; 
        tail -n +$(($line+1)) $AVAILABLE_LOCATION/$domain.conf; 
    } > $AVAILABLE_LOCATION/$domain.conf.orig
    mv $AVAILABLE_LOCATION/$domain.conf.orig $AVAILABLE_LOCATION/$domain.conf
fi

#create link to the new file
ln -s $AVAILABLE_LOCATION/$domain.conf $ENABLED_LOCATION

#create the directory in /var/www
mkdir $WEB_LOCATION/$domain

service apache2 restart

#install the certificate of the domain
sudo certbot --apache -d $domain
service apache2 restart