#!/bin/sh
curl -X GET \
  http://ec2-34-207-244-35.compute-1.amazonaws.com:8080/api/public/v1.0/serverPool \
  -H 'authorization: Digest username=\"michael.lynn@mongodb.com\", realm=\"MMS Public API\", nonce=\"\", uri=\"/api/public/v1.0/serverPool\", response=\"6312a4c0a9e0a0c6fa0f1dfc26423ab1\", opaque=\"\"' \
  -H 'cache-control: no-cache' \
  -H 'postman-token: 165c02ae-12c7-38d5-3926-5b4b9af6b3c8'
