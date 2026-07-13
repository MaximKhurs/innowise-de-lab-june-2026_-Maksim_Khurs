total_revenue = 0

daily_logs = [
    [500, 0, 1200],       # Касса 1 (Нормальная)
    [300, -999, 800],     # Касса 2 (Сломалась посередине, 800 не должно посчитаться)
    [1500, 200]           # Касса 3 (Нормальная)
]

for index, value in enumerate(daily_logs):
    print(f"--- Обработка Кассы №{index+1} ---")
    for i in value:
        if i > 0:
            print(f'Добавлено: {i}')
            total_revenue+=i
        elif i == 0:
            print(f'Сбой ({i}).')
            continue
        elif i == -999:
            print('Аварийная остановка кассы!')
            break

print(f'Общая выручка магазина: {total_revenue}')