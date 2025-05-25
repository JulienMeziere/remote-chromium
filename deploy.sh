#!/bin/bash
echo -n "Enter password for remote server: "
read -s PASSWORD
echo ""

sshpass -p "$PASSWORD" ssh julien@54.37.8.207 bash << EOF
  cd ./remote-chromium &&
  git checkout . &&
  git pull &&
  echo "$PASSWORD" | sudo -S rm -rf /var/www/browser.meziere.org/* &&
  echo "$PASSWORD" | sudo -S cp -r ~/remote-chromium/noVNC/* /var/www/browser.meziere.org/ &&
  echo "$PASSWORD" | sudo mv /var/www/browser.meziere.org/vnc.html /var/www/browser.meziere.org/index.html &&
  echo "$PASSWORD" | sudo -S systemctl restart remote-chromium &&
  echo "$PASSWORD" | sudo -S systemctl reload apache2
EOF
