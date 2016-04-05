#!/bin/bash

# Install script for in the docker container.
# Only should be used for local development!
# See docker_build for install scripts for other environments.
cd /var/www/html/;

# php profiles/social/modules/contrib/composer_manager/scripts/init.php
# composer drupal-rebuild
# composer update --lock

drush -y site-install social --db-url=mysql://root:root@db:3306/social --account-pass=admin install_configure_form.update_status_module='array(FALSE,FALSE)';
chown -R www-data:www-data /var/www/html/
php -r 'opcache_reset();';
chmod 444 sites/default/settings.php
drush pm-enable social_demo -y
drush cc drush
drush sda file user topic event eventenrollment comment # Add the demo content
#drush sdr file user topic event eventenrollment comment # Remove the demo content
drush pm-uninstall social_demo -y
