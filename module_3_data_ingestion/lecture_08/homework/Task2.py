branches = [
    {"city": "Minsk", "revenue": 15000},
    {"city": "Warsaw", "revenue": 32000},
    {"city": "London", "revenue": 12000}
]


def audit_logger(func):
    def wrapper(*args, **kwargs):
        print('[AUDIT] Запуск анализа....')
        result = func(*args, **kwargs)
        print('[AUDIT] Анализ завершен..')
        return result
    return wrapper
    
@audit_logger
def get_sorted_report(branches):
    sorted_cities = sorted(branches, key = lambda items: items['revenue'], reverse = True)
    report = "Топ филиалов:\n"
    for i, city_data in enumerate(sorted_cities, 1):
        report += f"{i}. {city_data['city']}: {city_data['revenue']}\n"
    
    return report
    
print(get_sorted_report(branches))