
              #!/bin/bash
              echo "Hello Students" > week3acs.txt
              yum -y update
              yum -y install httpd
              echo "<h1>Welcome to ACS730 Week 4!"  >  /var/www/html/index.html
              sudo systemctl start httpd
              sudo systemctl enable httpd
           EOF