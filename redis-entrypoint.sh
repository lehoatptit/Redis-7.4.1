#!/bin/sh

#khai bao bien duong dan file configure redis trong image da build
CONFIG_PATH="/etc/redis/conf/redis.conf"

# khoi dong service redis
exec redis-server $CONFIG_PATH

