# Working with Persistent Identifiers - Hands-on
This lecture takes you through the steps to create and administer PIDs employing the HTTP restful API.

curl -v -u "841:KosfwIxzG3" -H "Accept:application/json" -H "Content-Type:application/json" -X POST --data '[{"type":"URL","parsed_data":"http://www.test.com/test.html"}]' https://epic3.storage.surfsara.nl/v2_test/handles/841/
