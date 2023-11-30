#!/usr/bin/env bash

while true
do
  echo $(curl --write-out '%{http_code}' --silent --output /dev/null http://django.local/docs/)
done