import os
import pytest
import psycopg2

pg_conf = {
    'host': os.getenv("PG_HOST", 'localhost') ,
    'port': os.getenv("PG_PORT", '5432'),
    'user': os.getenv("PG_USER", 'postgres'),
    'password': os.getenv("PG_PASSWORD", 'password'),
    'dbname': os.getenv("PG_DBNAME", 'postgres')
}

@pytest.fixture(scope="session")
def db_conn():
    conn = psycopg2.connect(**pg_conf)
    yield conn
    conn.close()