# py-demo

基于 FastAPI 的 PostgreSQL 示例项目，附带 pytest 测试用例.

## 依赖

- Python 3.10+
- PostgreSQL
- 见 `requirements.txt`

## 快速开始

```bash
make dep
export PG_HOST=localhost
export PG_PORT=5432
export PG_USER=postgres
export PG_PASSWORD=password
export PG_DBNAME=postgres
psql "$PG_DBNAME" -f sql/schema.sql
psql "$PG_DBNAME" -f sql/seed.sql

# 启动服务
make run          # 或 python3 main.py，默认监听 0.0.0.0:8000

# 跑测试
make test
# 或生成 HTML 报告
python3 run_tests.py
```

环境变量未设置时，默认连接 `localhost:5432`，用户 `postgres`，库名 `postgres`；服务端口由 `PORT` 控制，默认 `8000`。

## 接口

| 方法 | 路径 | 说明 |
| --- | --- | --- |
| GET | `/products` | 商品列表，支持 `status`（默认 0）和 `limit`（默认 20）查询参数 |

```bash
curl "http://localhost:8000/products?status=0&limit=20"
```

## 项目结构

- `main.py`：FastAPI 应用与服务入口
- `run_tests.py`：并行跑测并输出 `report.html`
- `tests/conftest.py`：会话级数据库连接 fixture
- `tests/test_case.py`：商品可用数量断言与 `/products` 接口测试
- `sql/schema.sql`：建表
- `sql/seed.sql`：示例数据
- `Dockerfile` / `Makefile`：容器与常用命令
