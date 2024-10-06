## What is webserver-scripts ##

The repository contain the script which would install the necessary software for basic LAMP server

### Use init.sh ###

Use the script to install the apache, php and mysql and few additional things such as php version 7.4
for some projects. It also install certbot which is going to be used for creating new domains

Usage:
```
./init.sh
```

### Use new.domain.sh ###

The script is used to add a new domain to the server
```
./new.domain.sh
```
It's an interactive script which would ask the user what domain to create and what php version
You can specify the domain and php version in the script directly as:
```
./new.domain.sh {domain} {php}
```
For example:
```
./new.domain.sh domain.com 7.4
```
What the script would do:
1. Will create a file in /etc/apache2/sites-available named {domain.com}.conf
2. Will link that file into /etc/apache2/sites-enabled
3. Will add php version if needed
4. Will create directory for the domain in /var/www/{domain.com}
5. Will run certbot for that new domain and will restart the apache

You can use /resources/virtualhost.conf for the source of the virtualhost file. The file
contain directive for preventing browsing outside of the document root of the domain.
Feel free to modify /resources/virtualhost.conf if more configuration is needed.