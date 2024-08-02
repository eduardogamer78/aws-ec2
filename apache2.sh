#!/bin/bash

# Exit script on error
set -e

# Update package list
echo "Updating package list..."
sudo apt update

# Install Apache
echo "Installing Apache..."
sudo apt install -y apache2

# Start and enable Apache
echo "Starting and enabling Apache..."
sudo systemctl start apache2
sudo systemctl enable apache2

# Add PHP 7.4 repository
echo "Adding PHP 7.4 repository..."
sudo add-apt-repository -y ppa:ondrej/php
sudo apt update

# Install PHP 7.4 and extensions
echo "Installing PHP 7.4 and necessary extensions..."
sudo apt install -y php7.4 php7.4-cli php7.4-fpm php7.4-mysql php7.4-xml php7.4-mbstring

# Install phpMyAdmin
echo "Installing phpMyAdmin..."
sudo apt install -y phpmyadmin

# Configure Apache to use phpMyAdmin
echo "Configuring Apache for phpMyAdmin..."
sudo tee /etc/apache2/conf-available/phpmyadmin.conf > /dev/null <<EOL
Alias /phpmyadmin /usr/share/phpmyadmin

<Directory /usr/share/phpmyadmin>
    Options Indexes FollowSymLinks
    AllowOverride Limit Options FileInfo
    <IfModule mod_php7.c>
        AddType application/x-httpd-php .php
    </IfModule>
    <IfModule mod_php7.c>
        <FilesMatch "\.php$">
            SetHandler application/x-httpd-php
        </FilesMatch>
    </IfModule>
    <IfModule mod_dir.c>
        DirectoryIndex index.php
    </IfModule>
</Directory>

<Directory /usr/share/phpmyadmin/setup>
    <IfModule mod_authz_core.c>
        Require all granted
    </IfModule>
    <IfModule !mod_authz_core.c>
        Order Allow,Deny
        Allow from all
    </IfModule>
</Directory>
EOL

# Enable phpMyAdmin configuration
echo "Enabling phpMyAdmin configuration..."
sudo a2enconf phpmyadmin

# Restart Apache to apply changes
echo "Restarting Apache..."
sudo systemctl restart apache2

# Output completion message
echo "Installation completed. You can access phpMyAdmin at http://<your_server_ip>/phpmyadmin"
