import json 
api_response_json = """ 
{ 
	"store": "StoreHub", 
	"orders": [ 
		{"id": 1, "total": 50}, 
		{"id": 2, "total": 200}, 
		{"id": 3, "total": 150} 
		]
 } 
"""

api_response_dict = json.loads(api_response_json)

orders_list = []

for order in api_response_dict['orders']:
    orders_list.append(order)


high_value_orders = [value for value in orders_list if value['total'] > 100]

api_response_dict['high_value_orders'] = high_value_orders

api_response_json = json.dumps(api_response_dict)

print(api_response_json)

