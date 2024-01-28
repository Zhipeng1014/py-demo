import os

import psycopg2
import psycopg2.extras
import uvicorn
from fastapi import FastAPI

pg_conf = {
    'host': os.getenv("PG_HOST", 'localhost') ,
    'port': os.getenv("PG_PORT", '5432'),
    'user': os.getenv("PG_USER", 'postgres'),
    'password': os.getenv("PG_PASSWORD", 'password'),
    'dbname': os.getenv("PG_DBNAME", 'postgres')
}

app = FastAPI(title="py-demo")


@app.get("/products")
def list_products(status: int = 0, limit: int = 20):
    conn = psycopg2.connect(**pg_conf)
    try:
        cur = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
        cur.execute(
            "select id, name, sku, price, status from products where status = %s order by id limit %s",
            (status, limit),
        )
        rows = cur.fetchall()
        cur.close()
    finally:
        conn.close()
    return {"items": [dict(row) for row in rows]}


if __name__ == '__main__':
    uvicorn.run(app, host="0.0.0.0", port=int(os.getenv("PORT", "8000")))
