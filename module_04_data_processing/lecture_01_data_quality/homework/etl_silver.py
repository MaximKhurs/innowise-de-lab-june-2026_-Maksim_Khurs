import pandas as pd
from sqlalchemy import create_engine, text

DATABASE_URL = "postgresql://admin:123123123@localhost:5433/laba"
engine = create_engine(DATABASE_URL)


def validate_and_fix_date(date_str):
    """Исправляет кривые даты, возвращает 1900-01-01 если невозможно"""
    try:
        date_obj = pd.to_datetime(date_str, errors='coerce', dayfirst=True)
        if pd.isna(date_obj):
            return '1900-01-01'
        if date_obj.year < 1900 or date_obj.year > 2100:
            return '1900-01-01'
        return date_obj.strftime('%Y-%m-%d')
    except Exception:
        return '1900-01-01'


def load_to_silver():

    try:
        df_countries = pd.read_sql_table('bronze_countries', con=engine, schema='bronze')
        df_categories = pd.read_sql_table('bronze_categories', con=engine, schema='bronze')
        df_cities = pd.read_sql_table('bronze_cities', con=engine, schema='bronze')
        df_products = pd.read_sql_table('bronze_products', con=engine, schema='bronze')
        df_shops = pd.read_sql_table('bronze_shops', con=engine, schema='bronze')
        df_customers = pd.read_sql_table('bronze_customers', con=engine, schema='bronze')

        # === ПРЕОБРАЗОВАНИЕ BOOLEAN ===
        df_products['resistant'] = df_products['resistant'].map({'Yes': True, 'No': False}).fillna(False)
        df_products['is_allergic'] = df_products['is_allergic'].map({'Yes': True, 'No': False}).fillna(False)

        # Загрузка
        df_countries.to_sql('silver_countries', con=engine, schema='silver', if_exists='append', index=False)
        df_categories.to_sql('silver_categories', con=engine, schema='silver', if_exists='append', index=False)
        df_cities.to_sql('silver_cities', con=engine, schema='silver', if_exists='append', index=False)
        df_products.to_sql('silver_products', con=engine, schema='silver', if_exists='append', index=False)
        df_shops.to_sql('silver_shops', con=engine, schema='silver', if_exists='append', index=False)
        df_customers.to_sql('silver_customers', con=engine, schema='silver', if_exists='append', index=False)

        print('Все справочники загружены!')
    except Exception as e:
        print(f'Ошибка загрузки справочников: {e}')
        raise


def process_employees():
    """Обрабатывает и загружает сотрудников"""
    try:
        df_employees = pd.read_sql_table('bronze_employees', con=engine, schema='bronze')
        
        df_employees['birth_date'] = df_employees['birth_date'].apply(validate_and_fix_date)
        df_employees['hire_date'] = df_employees['hire_date'].apply(validate_and_fix_date)
        
        df_employees.to_sql(
            name='silver_employees',
            con=engine,
            schema='silver',
            if_exists='append',
            index=False
        )
        print(f'Сотрудники загружены! Всего строк: {len(df_employees)}')
    except Exception as e:
        print(f'Ошибка загрузки сотрудников: {e}')
        raise


def process_sales():
    """Обрабатывает и загружает продажи"""
    try:
        df_sales = pd.read_sql_table('bronze_sales', con=engine, schema='bronze')
        
        df_sales['sales_timestamp'] = pd.to_datetime(df_sales['sales_timestamp'], errors='coerce')
        
        initial_count = len(df_sales)
        df_sales = df_sales.dropna(subset=['sales_timestamp'])
        removed_count = initial_count - len(df_sales)
        if removed_count > 0:
            print(f'Удалено {removed_count} строк с пустыми датами')
        
        df_sales['sales_timestamp'] = df_sales['sales_timestamp'].fillna(pd.Timestamp('1900-01-01 00:00:00'))
        
        # Добавляем колонки для обогащения
        df_sales['city_id'] = None
        df_sales['shop_id'] = None
        
        df_sales.to_sql(
            name='silver_sales',
            con=engine,
            schema='silver',
            if_exists='append',
            index=False,
            chunksize=10000
        )
        print(f'Продажи загружены! Всего строк: {len(df_sales)}')
    except Exception as e:
        print(f'Ошибка загрузки продаж: {e}')
        raise


def main():
    try:
        load_to_silver()
        process_employees()
        process_sales()
        print("Данные успешно загружены")
    except Exception as e:
        print(f"Ошибка выполнения ETL: {e}")
        exit(1)



main()