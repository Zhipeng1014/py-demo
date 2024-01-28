-- PostgreSQL schema for pytest-demo
-- Used by tests/test_case.py (products.status = 0 means available)

CREATE TABLE IF NOT EXISTS products (
    id          BIGSERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    sku         VARCHAR(64) UNIQUE,
    price       NUMERIC(12, 2) NOT NULL DEFAULT 0,
    status      SMALLINT NOT NULL DEFAULT 0,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON COLUMN products.status IS '0 = available, 1 = offline, 2 = deleted';

CREATE INDEX IF NOT EXISTS idx_products_status ON products (status);
