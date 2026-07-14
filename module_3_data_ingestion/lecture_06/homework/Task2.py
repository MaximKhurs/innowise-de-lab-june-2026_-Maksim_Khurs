prices = [100, -50, 300, 40, 800]

prices.remove(-50)

prices.append(150)

new_prices = prices.sort()

tax_prices = [x*1.2 for x in prices if x*1.2 > 100]

print(f'Базовый прайс (очищенный): {new_prices}')
print(f'Цены с НДС (>100): {tax_prices}')
print(f'Общая выручка: {sum(tax_prices)}')
print(f'Минимум: {min(tax_prices)}')
print(f'максимум: {max(tax_prices)}')