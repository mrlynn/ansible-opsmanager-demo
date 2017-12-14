{
"_id": "$objectid",
"ip_address": "$ip",
"percent": {"$floating": {"min": 0, "max": 100, "fixed": 8}},
"birthday": {"$birthday": {"type": "child"}},
"phone_no": "$phone",
"full_name": "$name",
"gender": {"$choose": {"from": ["male", "female"], "weights": [2, 1]}},
"status": {"$choose": {"from": ["read", "unread", "deleted"], "weights": [2, 1, 1]}}
}
