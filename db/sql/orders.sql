-- postOrder
INSERT INTO "order" ("customer_id", "status") VALUES (:customerId, 'New')
RETURNING *;

-- postOrderProduct
INSERT INTO "order_product" ("order_id", "product_id", "amount") VALUES (:orderId, :productId, :amount)
ON CONFLICT ("order_id", "product_id") DO UPDATE
SET amount = :amount
RETURNING *;

-- getOrders
SELECT
  a.order_id,
  a.status,
  b.name,
  b.address
FROM "order" a
JOIN "customer" b USING (customer_id)

-- getOrderById
SELECT
  a.order_id,
  a.status,
  b.name,
  b.address
FROM "order" a
JOIN "customer" b USING (customer_id)
WHERE a.order_id = :orderId

-- getOrderItems
SELECT
  b.name,
  b.size,
  b.price,
  a.amount
FROM "order_product" a
JOIN "product" b USING (product_id)
WHERE a.order_id = :orderId

-- putOrder
UPDATE "order"
SET "status" = :status
WHERE order_id = :orderId
RETURNING *

-- putOrderItem
UPDATE "order_product"
SET "product_id" = :newProductId,
    "amount" = :amount
WHERE order_id = :orderId
AND   product_id = productId

-- deleteOrderItems
DELETE
FROM "order_product" a
WHERE a.order_id = :orderId

-- deleteOrder
DELETE
FROM "order" a
WHERE a.order_id = :orderId