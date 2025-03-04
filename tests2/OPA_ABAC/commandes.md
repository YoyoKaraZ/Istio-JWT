ALICE_TOKEN=$(curl -X POST -d "client_id=new_site_client" -d "username=alice" -d "password=alice123" -d "grant_type=password" http://192.168.39.239:31552/realms/new_site_realm/protocol/openid-connect/token -s |jq '.access_token' |sed 's/"//g')

curl http://new-site.com/paris -H "Authorization: Bearer $ALICE_TOKEN" -s -w '%{http_code}\n'
