#!/bin/bash
sudo yum install tomcat9 -y
sudo yum -y install httpd

# Configuración del proxy inverso
sudo cat << EOF > /etc/httpd/conf.d/tomcat.conf
<VirtualHost *:80>
    ServerAdmin root@localhost
    ServerName ec2-18-237-98-37.us-west-2.compute.amazonaws.com
    
    ProxyPreserveHost On
    ProxyPass / http://localhost:8080/nextwork-web-project/
    ProxyPassReverse / http://localhost:8080/nextwork-web-project/
    
    ErrorLog /var/log/httpd/nextwork-error.log
    CustomLog /var/log/httpd/nextwork-access.log combined
</VirtualHost>
EOF

# Habilitar módulos necesarios
sudo systemctl enable httpd
sudo systemctl enable tomcat9
