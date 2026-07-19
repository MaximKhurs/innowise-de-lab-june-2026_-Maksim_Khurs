import pandas as pd
from sqlalchemy import create_engine, text
from sqlalchemy.exc import SQLAlchemyError

DATABASE_URL = "postgresql://admin:123123123@localhost:5433/laba"


def create_db_connection():
    """
    Создаёт подключение к базе данных PostgreSQL.
    
    Returns:
        engine: объект SQLAlchemy Engine для работы с БД.
        
    Raises:
        SystemExit: при ошибке подключения.
    """
    try:
        engine = create_engine(DATABASE_URL)

        with engine.connect() as conn:
            print("Подключение к БД успешно установлено!!!")

    except SQLAlchemyError as e:
        print(f"Ошибка подключения к БД: {e}")
        exit(1)

    print("Engine готов к работе!")
    return engine


def create_schema(engine):
    """
    Создаёт схему bronze, если она ещё не существует.
    
    Args:
        engine: объект SQLAlchemy Engine.
        
    Raises:
        SystemExit: при ошибке создания схемы.
    """
    try:
        with engine.connect() as conn:
            conn.execute(text("CREATE SCHEMA IF NOT EXISTS bronze"))
            conn.commit()
            print("Схема bronze создана (или уже существует)")
    except SQLAlchemyError as e:
        print(f"Ошибка создания схемы: {e}")
        exit(1)


def load_csv_to_table(csv_path: str, table_name: str, engine):
    """
    Загружает CSV-файл в таблицу в схеме bronze.
    
    Args:
        csv_path (str): путь к CSV-файлу.
        table_name (str): имя таблицы в БД.
        engine: объект SQLAlchemy Engine.
    """
    try:
        df = pd.read_csv(csv_path, encoding="cp1251", sep=";")
        print(f"Загрузка {csv_path}: {len(df)} строк")

        df.to_sql(
            name=table_name,
            con=engine,
            if_exists="append",
            index=False,
            schema="bronze",
        )

        print(f"Таблица {table_name} успешно загружена.")

    except Exception as e:
        print(f"Ошибка загрузки {csv_path}: {e}")


def load_sales(csv_path: str, table_name: str, engine, chunksize: int = 1000):
    """
    Загружает sales.csv с преобразованием дат и пакетной вставкой.
    
    Args:
        csv_path (str): путь к CSV-файлу.
        table_name (str): имя таблицы в БД.
        engine: объект SQLAlchemy Engine.
        chunksize (int): размер пакета для вставки.
    """
    try:
        df = pd.read_csv(csv_path, encoding="cp1251", sep=";")

        print(f"Загрузка {csv_path}: {len(df)} строк")

        # Преобразование даты (pandas автоматически определяет формат)
        df["sales_timestamp"] = pd.to_datetime(df["sales_timestamp"], errors="coerce")

        bad_dates = df["sales_timestamp"].isna().sum()
        if bad_dates > 0:
            print(f"Найдено {bad_dates} некорректных дат (заменены на NULL)")
        else:
            print("Все даты успешно преобразованы!")

        df.to_sql(
            name=table_name,
            con=engine,
            schema="bronze",
            if_exists="append",
            index=False,
            chunksize=chunksize,
        )

        print(f"Таблица {table_name} успешно загружена!")

    except Exception as e:
        print(f"Ошибка загрузки {csv_path}: {e}")
        raise


def create_primary_keys(engine):
    """
    Создаёт первичные ключи (PRIMARY KEY) в таблицах схемы bronze.
    """
    try:
        with engine.connect() as conn:
            print("Создание первичных ключей...")
            
            primary_keys = [
                """
                ALTER TABLE bronze.bronze_countries 
                ADD CONSTRAINT pk_countries PRIMARY KEY (country_id)
                """,
                """
                ALTER TABLE bronze.bronze_cities 
                ADD CONSTRAINT pk_cities PRIMARY KEY (city_id)
                """,
                """
                ALTER TABLE bronze.bronze_categories 
                ADD CONSTRAINT pk_categories PRIMARY KEY (category_id)
                """,
                """
                ALTER TABLE bronze.bronze_products 
                ADD CONSTRAINT pk_products PRIMARY KEY (product_id)
                """,
                """
                ALTER TABLE bronze.bronze_shops 
                ADD CONSTRAINT pk_shops PRIMARY KEY (shop_id)
                """,
                """
                ALTER TABLE bronze.bronze_employees 
                ADD CONSTRAINT pk_employees PRIMARY KEY (employee_id)
                """,
                """
                ALTER TABLE bronze.bronze_customers 
                ADD CONSTRAINT pk_customers PRIMARY KEY (customer_id)
                """,
                """
                ALTER TABLE bronze.bronze_sales 
                ADD CONSTRAINT pk_sales PRIMARY KEY (sales_id)
                """,
            ]
            
            for query in primary_keys:
                try:
                    conn.execute(text(query))
                    conn.commit()
                    print("Первичный ключ создан")
                except Exception as e:
                    if "already exists" in str(e).lower():
                        print("Ключ уже существует, пропускаем")
                    else:
                        print(f"Ошибка: {e}")
            
            print("Все первичные ключи созданы!")
            
    except Exception as e:
        print(f"Ошибка создания первичных ключей: {e}")


def create_foreign_keys(engine):
    """
    Создаёт внешние ключи (Foreign Keys) в схеме bronze.
    Каждый ключ создаётся в отдельной транзакции.
    
    Args:
        engine: объект SQLAlchemy Engine.
    """
    print("Создание внешних ключей...")
    
    foreign_keys = [
        # cities → countries
        """
        ALTER TABLE bronze.bronze_cities 
        ADD CONSTRAINT fk_cities_countries 
        FOREIGN KEY (country_id) REFERENCES bronze.bronze_countries(country_id)
        """,
        # customers → cities
        """
        ALTER TABLE bronze.bronze_customers 
        ADD CONSTRAINT fk_customers_cities 
        FOREIGN KEY (city_id) REFERENCES bronze.bronze_cities(city_id)
        """,
        # employees → cities
        """
        ALTER TABLE bronze.bronze_employees 
        ADD CONSTRAINT fk_employees_cities 
        FOREIGN KEY (city_id) REFERENCES bronze.bronze_cities(city_id)
        """,
        # employees → shops
        """
        ALTER TABLE bronze.bronze_employees 
        ADD CONSTRAINT fk_employees_shops 
        FOREIGN KEY (shop_id) REFERENCES bronze.bronze_shops(shop_id)
        """,
        # products → categories
        """
        ALTER TABLE bronze.bronze_products 
        ADD CONSTRAINT fk_products_categories 
        FOREIGN KEY (category_id) REFERENCES bronze.bronze_categories(category_id)
        """,
        # sales → employees
        """
        ALTER TABLE bronze.bronze_sales 
        ADD CONSTRAINT fk_sales_employees 
        FOREIGN KEY (employee_id) REFERENCES bronze.bronze_employees(employee_id)
        """,
        # sales → customers
        """
        ALTER TABLE bronze.bronze_sales 
        ADD CONSTRAINT fk_sales_customers 
        FOREIGN KEY (customer_id) REFERENCES bronze.bronze_customers(customer_id)
        """,
        # sales → products
        """
        ALTER TABLE bronze.bronze_sales 
        ADD CONSTRAINT fk_sales_products 
        FOREIGN KEY (product_id) REFERENCES bronze.bronze_products(product_id)
        """,
    ]
    
    for query in foreign_keys:
        try:
            # Каждый запрос в своей транзакции
            with engine.begin() as conn:
                conn.execute(text(query))
                print("Внешний ключ создан")
        except Exception as e:
            error_msg = str(e).lower()
            if "already exists" in error_msg or "duplicate" in error_msg:
                print("Ключ уже существует, пропускаем")
            elif "violates" in error_msg:
                print(f"Ошибка данных: {e}")
                print("   Проверьте, что все ID существуют в родительских таблицах")
            else:
                print(f"Ошибка: {e}")
    
    print("Завершено создание внешних ключей!")



def main():
    """
    Главная функция ETL-процесса.
    Выполняет загрузку всех справочников, продаж и создание внешних ключей.
    """
    engine = create_db_connection()
    create_schema(engine)

    # === ЭТАП 2: ЗАГРУЗКА СПРАВОЧНИКОВ ===

    print("ЗАГРУЗКА СПРАВОЧНИКОВ")


    files = [
        ("data/countries.csv", "bronze_countries"),
        ("data/cities.csv", "bronze_cities"),
        ("data/categories.csv", "bronze_categories"),
        ("data/products.csv", "bronze_products"),
        ("data/shops.csv", "bronze_shops"),
        ("data/employees.csv", "bronze_employees"),
        ("data/customers.csv", "bronze_customers"),
    ]

    for csv_path, table_name in files:
        load_csv_to_table(csv_path, table_name, engine)

    print("Все справочники загружены!")

    # === ЭТАП 3: ЗАГРУЗКА ПРОДАЖ ===

    print("ЗАГРУЗКА ПРОДАЖ")

    load_sales("data/sales.csv", "bronze_sales", engine, chunksize=10000)

    # === ПЕРВИЧНЫЕ КЛЮЧИ ===

    create_primary_keys(engine)
    # === ВНЕШНИЕ КЛЮЧИ ===
    create_foreign_keys(engine)

    print("\n" + "=" * 50)
    print("ВСЕ ДАННЫЕ УСПЕШНО ЗАГРУЖЕНЫ!")
    print("=" * 50)


if __name__ == "__main__":
    main()