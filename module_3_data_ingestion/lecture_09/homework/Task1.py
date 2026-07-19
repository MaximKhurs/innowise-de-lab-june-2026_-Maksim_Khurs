def calculate_purchase(product_name, weight, price):
    """
    Рассчитывает общую стоимость товара и его технический индекс
    
    Функция вычисляет итоговую стомость партии на основе веса и цены.
    В процессе выполнения обрабатываются возможные ошибки ввода данных
    
    Args: product_name(str): Название товара;
          weight(int, float, decimal):  Итоговый вес товара;
          price(int, float, decimal): Цена за единицу товара;
    """
    try:
        numeric_weight = float(weight)
        total_cost = numeric_weight * price
        technical_index = 100 / numeric_weight
    except TypeError as t:
        print('Неподходящий тип для числа')
        print('Тип ошибки: TypeError')
        print(f'Сообщение: {t}')
    except ValueError as v:
        print('В numeric_weight передан текст')
        print('Тип ошибки: ValueError')
        print(f'Сообщение: {v}')
    except ZeroDivisionError as z:
        print('Деление на 0 невозможно')
        print('Тип ошибки: ZeroDivisionError')
        print(f'Сообщение: {z}')
    finally:
        print('--- Проверка партии завершена ---')
    return product_name, total_cost

a, b = calculate_purchase('Томаты', 100, 2.5)
print(f'Товар: {a}. Итоговая стоимость: {b}')

c,d = calculate_purchase('Огурцы', 'пятьдесят', 1.8)
print(f'Товар: {c}. Итоговая стоимость: {d}')

g,h = calculate_purchase ('Перец', 0, 4)
print(f'Товар: {g}. Итоговая стоимость: {h}')

i,j = calculate_purchase ('Зелень', [10], 5)
print(f'Товар: {i}. Итоговая стоимость: {j}')
