-- getProductId
SELECT
  a.product_id
FROM "product" a
WHERE name = :name
AND   size = :size

-- getProducts
SELECT
  a.product_id,
  a.name,
  a.size,
  a.price,
  a.description
FROM "product" a