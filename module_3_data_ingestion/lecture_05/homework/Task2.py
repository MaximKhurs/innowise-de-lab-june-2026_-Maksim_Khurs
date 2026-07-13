product = " фермерский ТВОРОГ " 
price = 4.567 
qty = 3 
csv_row = "milk,bread,cheese" 
review = "Это лучший ТВОРОГ в городе!" 
file_path = r"C:\EcoMarket\data\2025\january\sales.csv"


clean_product = product.strip().lower().title()
print(f'Чек\t"EcoMarket"\nТовар:\t{clean_product}\nКол-во:\t{qty}\nИтого:\t{round(qty*price, 2)}')

csv_new = csv_row.split(',')
csv_clean = ' | '.join(csv_new)
print(csv_clean)


if 'творог' in review.lower():
    print('Отзыв относится к категории: Dairy')

print(file_path)

# Используется r так как обратный слэш с символом может восприниматься не как текст, 
# а как какой то функционал типо переноса или табуляции