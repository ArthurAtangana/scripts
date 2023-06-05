#!/bin/sh

# Customize with your data
APIKEY="api-key"
DOMAINS="domain1.com domain2.com"
RECORD="@"

# DO NOT EDIT AFTER THIS LINE
CURRENTIP=$(curl -s ifconfig.co/ip)
IPLENGTH=$(echo -n ${CURRENTIP} | wc -m)

# Check that ifconfig.co returns an IP
if [ ${IPLENGTH} -gt 30 ]
then
  exit 1
fi

for DOMAIN in $DOMAINS; do
  echo "Domain: $DOMAIN"
  # Get gandi's NS for my domain
  NS=$(curl -s --header "Authorization: Apikey ${APIKEY}" https://api.gandi.net/v5/livedns/domains/${DOMAIN}/nameservers | jq  --raw-output '.[0] | sub("^.*?_"; "")')
  # echo "NameServer: $NS"
  # Get the last IP recorded
  LASTREGISTEREDIP=$(dig +short ${DOMAIN} @${NS})
  # echo "previous ip: $LASTREGISTEREDIP"

  # Update if needed
  if [ "${CURRENTIP}" != "${LASTREGISTEREDIP}" ]
  then
    curl -X PUT \
      https://api.gandi.net/v5/livedns/domains/${DOMAIN}/records/${RECORD}/A \
      -H "authorization: Apikey ${APIKEY}" \
      -H 'content-type: application/json' \
      -d "{\"rrset_values\": [\"${CURRENTIP}\"], \"rrset_ttl\": "320"}"
  else
    echo "IP up to date"
    echo "last registered ip:$LASTREGISTEREDIP"
    echo "current ip:$CURRENTIP"
  fi
done
echo "Done"