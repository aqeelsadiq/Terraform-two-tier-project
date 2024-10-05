#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl enable apache2
echo "<html>
  <head>
    <title>Hello World Page</title>
  </head>
  <body>
    <h1>Hello, World! this is terraform project </h1>
  </body>
</html>"  > /var/www/html/index.html
sudo systemctl restart apache2


