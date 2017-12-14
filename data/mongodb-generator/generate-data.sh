#!/bin/sh
#mgeneratejs --host localhost --port 27017 -d fraudGraphLookup -c nodes -n 10000 fraud_accountholders.json
#mgeneratejs --host localhost --port 27017 -d fraudGraphLookup -c nodes -n 10000 fraud_creditcards.json
#mgeneratejs --host localhost --port 27017 -d fraudGraphLookup -c nodes -n 10000 fraud_phonenumbers.json
#mgeneratejs --host localhost --port 27017 -d fraudGraphLookup -c links -n 10000 fraud_links.json

mgeneratejs fraud_accountholders.json -n 100 | mongoimport -d fraud -c nodes
mgeneratejs fraud_creditcards.json -n 100 | mongoimport -d fraud -c nodes
mgeneratejs fraud_phonenumbers.json -n 100 | mongoimport -d fraud -c nodes
mgeneratejs fraud_links.json -n 100 | mongoimport -d fraud -c links
