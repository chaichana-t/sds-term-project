# !/bin/bash

apt update -y
apt upgrade -y
apt install -y apache2 libapache2-mod-php7.4
apt install -y php7.4-gd php7.4-mysql php7.4-curl php7.4-mbstring php7.4-intl
apt install -y php7.4-gmp php7.4-bcmath php-imagick php7.4-xml php7.4-zip
apt install -y unzip

wget https://download.nextcloud.com/server/releases/nextcloud-22.2.0.zip
unzip nextcloud-22.2.0.zip
mv nextcloud/* /var/www/html

a2enmod rewrite
a2enmod ssl
a2ensite default-ssl

service apache2 restart

cd /var/www/html

echo "<?php
\$CONFIG = array (
  'objectstore' => array(
        'class' => '\\OC\\Files\\ObjectStore\\S3',
        'arguments' => array(
                'bucket'  => '${bucket_name}',
                'key'     => '${key}',
                'secret'  => '${secret}',
                'port'    => 443,
                'use_ssl' => true,
                'region'  => '${region}',
                'use_path_style'=>true,
        ),
  ),
);" > ./config/config.php

php occ maintenance:install \
  --database      "${database}" \
  --database-name "${database_name}" \
  --database-user "${database_user}" \
  --database-pass "${database_pass}" \
  --admin-user    "${admin_user}" \
  --admin-pass    "${admin_pass}" \
  --database-host "${database_host}"

php occ config:system:set trusted_domains 1 --value=${public_ip}

chown -R www-data:www-data /var/www/html
