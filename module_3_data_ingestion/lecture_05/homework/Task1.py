raw_log = "ORDER-2025-01-15|FRT-APPLE-PL|+111 (23) 456-78-90| мИНсК "

list_log = raw_log.split('|')

order_id = list_log[0]
product_code = list_log[1]
raw_phone = list_log[2]
raw_city = list_log[3]

category = product_code[0:3]
region = product_code [-2:]
print(f'Позиция первого дефиса в коде товара {product_code.find('-')}')
if product_code.startswith('FRT'):
    print("Код товара начинается с 'FRT'")
else:
    print("Код товара не начинается с 'FRT'")

clean_phone = ''

for i in raw_phone:
    if i.isdigit():
        clean_phone+=i
print(f"Длина номера телефона: {len(clean_phone)}")

clean_city= raw_city.strip().lower().title()
report = f"Заказ:\t{raw_log}\nКатегория: {category} | Регион: {region}\nТелефон: {clean_phone}\nГород: {clean_city}"
print(report)