SMALL_BATCH_LIMIT = 500
def calculate_batch(weight, price, discount = 0.0):
    final_sum = weight * price * (1-discount)
    if final_sum > SMALL_BATCH_LIMIT:
        is_limit_exceeded = True
    else:
        is_limit_exceeded = False
        
    return final_sum, is_limit_exceeded

carrot_sum, carrot_exceeded = calculate_batch(100,4)
apple_sum, apple_exceeded = calculate_batch(50, 20, 0.1)

print(f"Партия 1 (Морковь): Сумма {carrot_sum}. Превышение лимита: {carrot_exceeded}")
print(f"Партия 2 (Яблоки): Сумма {apple_sum}. Превышение лимита: {apple_exceeded}")