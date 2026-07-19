
class Products:
    def __init__(self, name: str , __price: float|int):
        self.name = name
        self.__price = __price
    def get_price(self):
        return self.__price
    def set_price(self, new_price):
        if new_price > 0:
            self.__price = new_price
        else:
            print('Ошибка безопасности: Цена должна быть положительной!')
    def get_display_info(self):
        return f"Товар: {self.name} | Цена: {self.get_price()} руб."

    def calculate_cost(self):
        return self.get_price()
  
        
class WeighableProduct(Products):
    def __init__(self,name: str, __price: float|int, weight: float):
        super().__init__(name, __price)
        self.weight = weight
    
    def calculate_cost(self):
        total_cost = self.weight * self.get_price()
        return total_cost
        
        
    def get_display_info(self):
        return  f'Весовой товар:{self.name} | Вес {self.weight} кг | Итого: {self.calculate_cost()} руб.'
        
 
        
class PackagedProduct(Products):
    def __init__(self,name:str, __price: float|int, quantity:int):
        super().__init__(name, __price)
        self.quantity = quantity
        
    def calculate_cost(self):
        total_cost = self.quantity * self.get_price()
        return total_cost    
        
    def get_display_info(self):
        return  f'Упаковка :{self.name} | Количество {self.quantity} шт. | Итого: {self.calculate_cost()} руб.'
        

cart = []

cart.append(Products("Молоко", 100))
cart.append(WeighableProduct("Яблоки", 50, 2.5))
cart.append(PackagedProduct("Яйца", 12, 10))

cart[0].set_price(-200)
print('--- Чек EcoMarket ---')
total_calculate_cost = 0
for item in cart:
    print(item.get_display_info())
    total_calculate_cost += item.calculate_cost()
print('---------------------')    
print(f'Итого к оплате: {total_calculate_cost}')