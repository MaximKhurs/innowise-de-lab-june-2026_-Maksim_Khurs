from typing import Union, Optional

def calculate_total_delivery_cost (
    product_name: str, 
    weight: Union[list[float], tuple[float]], 
    prices: Union [list[float], tuple[float]],
    discount: Optional[float] = None,
    currency_rate: Union [int, float] = 1,
    *extra_costs: float) -> dict[str,float]:
    
    if len(weight) != len(prices):
        print('Количество элеметнов не совпадает')
    total_sum: float = 0.0
    for i in range(len(weight)):
       total_sum += weight[i] * prices[i]
    
    discount_sum:float = total_sum
    if discount is not None:
        discount_sum = total_sum * (1 - discount)
    extra_sum:float = sum(extra_costs)
    final_sum: float = (discount_sum + extra_sum) * currency_rate
    return {product_name: final_sum}
    
vegetables_res = calculate_total_delivery_cost(
    "Овощная партия",
    [100, 50],
    [4, 6],
    0.1,
    1,
    20, 15
)

fruits_res = calculate_total_delivery_cost(
    "Фруктовая партия",
    (30, 20, 10),
    (15, 12, 18),
    None,
    1.2,
    25
)


print(f"Товар: Овощная партия, итоговая стоимость: {vegetables_res['Овощная партия']}")
print(f"Товар: Фруктовая партия, итоговая стоимость: {fruits_res['Фруктовая партия']}")