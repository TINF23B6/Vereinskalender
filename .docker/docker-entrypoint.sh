#!/bin/bash

# Setze die Zeitzone in die php.ini
echo "date.timezone=${TZ}" > /usr/local/etc/php/conf.d/99-timezone.ini

sleep 10

# Starte Apache
exec apache2-foreground
