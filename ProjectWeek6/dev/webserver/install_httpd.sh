#!/bin/bash
sudo yum -y update
sudo yum -y install httpd
cd /var/www/html/

sudo curl -0 https://webserver-group17.s3.amazonaws.com/index.html --output index.html
sudo curl -0 https://webserver-group17.s3.amazonaws.com/daffodil.jpeg --output daffodil.jpeg
sudo curl -0 https://webserver-group17.s3.amazonaws.com/daisy.jpeg --output daisy.jpeg
sudo curl -0 https://webserver-group17.s3.amazonaws.com/hibiscus.jpeg --output hibiscus.jpeg
sudo curl -0 https://webserver-group17.s3.amazonaws.com/lilly.jpeg --output lilly.jpeg 
sudo curl -0 https://webserver-group17.s3.amazonaws.com/rose.jpeg --output rose.jpeg
sudo curl -0 https://webserver-group17.s3.amazonaws.com/sunflower.jpeg --output sunflower.jpeg
sudo curl -0 https://webserver-group17.s3.amazonaws.com/tulip.jpeg --output tulip.jpeg 

sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl restart httpd