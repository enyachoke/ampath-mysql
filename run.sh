echo "Setup cron"
service rsyslog start
service cron start
mysqld --user=root