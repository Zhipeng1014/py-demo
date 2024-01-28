import pytest
import psycopg2
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)


class TestCase():

    def test_products(self, db_conn):
        cur = db_conn.cursor()
        cur.execute("select count(*) from products where status = 0")
        count = cur.fetchone()[0]
        assert count > 0, f"assert {count} > 0"
        cur.close()

    def test_list_products_api(self):
        resp = client.get("/products")
        assert resp.status_code == 200, resp.text
        items = resp.json()["items"]
        assert len(items) > 0, f"assert {len(items)} > 0"
        assert all(item["status"] == 0 for item in items)
