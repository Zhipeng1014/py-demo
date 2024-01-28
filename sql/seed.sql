INSERT INTO products (name, sku, price, status) VALUES
    ('Demo Widget', 'SKU-001', 19.90, 0),
    ('Offline Item', 'SKU-002', 9.90, 1)
ON CONFLICT (sku) DO NOTHING;
