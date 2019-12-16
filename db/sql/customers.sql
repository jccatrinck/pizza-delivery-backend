-- postCustomer
INSERT INTO "customer" ("name", "address") VALUES (:name, :address)
ON CONFLICT (name) DO UPDATE
SET address = :address
RETURNING *;

-- getCustomerByName
SELECT
  a.name,
  a.address
FROM "customer" a
WHERE a.name = :name
