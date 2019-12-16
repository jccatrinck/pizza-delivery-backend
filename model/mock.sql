INSERT INTO "product" ("name", "size", "price", "description") VALUES
  ('Margarita',  'Small',  9.95,  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
  ('Margarita',  'Medium', 19.95, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
  ('Margarita',  'Large',  29.95, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
  ('Marinara',   'Small',  11.95, 'There are many variations of passages of Lorem Ipsum available'),
  ('Marinara',   'Medium', 21.95, 'There are many variations of passages of Lorem Ipsum available'),
  ('Marinara',   'Large',  31.95, 'There are many variations of passages of Lorem Ipsum available'),
  ('Salami',     'Small',  12.95, 'Randomised words which don''t look even slightly believable'),
  ('Salami',     'Medium', 22.95, 'Randomised words which don''t look even slightly believable'),
  ('Salami',     'Large',  32.95, 'Randomised words which don''t look even slightly believable');

INSERT INTO "customer" (name, address) VALUES ('Terminator', 'Unter den Linden 2, 10117 Berlin, Germany');

INSERT INTO "order" ("customer_id", status) VALUES (1, 'New');

INSERT INTO "order_product" ("product_id", "amount") VALUES (1, 1);