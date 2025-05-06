#!/bin/python3

import os
import json

target_container = input("Which container would you like to extract user data from? (HAS TO BE NEXTCLOUD): ")

user_amount_stream = os.popen(f'docker exec {target_container} occ user:list | grep -c " - "')
user_amount = user_amount_stream.read()
user_amount_stream.close()

user_list_stream = os.popen(f'docker exec {target_container} occ user:list --info --output=json_pretty --limit {user_amount}')
user_list = user_list_stream.read()
user_list_stream.close()

json_user_list = json.loads(user_list)
keys = list(json_user_list.keys())

for name in keys:
    print(f'User: {name}')
    print(f'    Last_Seen: {json_user_list[name]["last_seen"]}')