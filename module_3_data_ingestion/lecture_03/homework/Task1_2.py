#1
product_name = "Морковь мытая"
price = 2.5
stock_quantity = 150
is_local_farm = True
supplier = None

has_coupon = True
has_card = False
total = 10


#2
is_hit = True if price < 3 and is_local_farm else False


#3
print(f'Является ли товар хитом? {is_hit}')


#4
has_supplier = True if supplier is not None else False
print(f"Поставщик указан? {has_supplier}")

can_show_in_app = True if supplier is not None and stock_quantity > 0 else False
print(f"Показывать в приложении? {can_show_in_app}")

needs_restock = True if stock_quantity < 20 or is_hit else False
print(f"Нужно пополнение? {needs_restock}")

is_blocked = True if not is_local_farm else False
print(f"Товар заблокирован для акции? {is_blocked}")


#5
discount_without_brackets = has_coupon or has_card and total > 50

discount_with_brackets = (has_coupon or has_card) and total > 50

print(f'Скидка  без скобок {discount_without_brackets}')
print(f'Скидка  со скобками {discount_with_brackets}')


#6
price += 1.0
stock_quantity *= 2

boxes = stock_quantity
boxes //=10

is_hit = True if price < 3 and is_local_farm else False
needs_restock = True if stock_quantity < 20 or is_hit else False
print(f'Является ли товар хитом (после изменений)? {is_hit}')
print(f"Нужно пополнение (после изменений)? {needs_restock}")