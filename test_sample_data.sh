source setup.sh
set -e

[[ -f schema.sql ]] || wget -q4 https://raw.githubusercontent.com/yugabyte/yb-sql-workshop/master/query-using-bi-tools/schema.sql

[[ -f sample-data.tgz ]] || wget -q4 https://github.com/yugabyte/yb-sql-workshop/raw/master/query-using-bi-tools/sample-data.tgz

[[ -d data ]] || tar zxvf sample-data.tgz


docker cp ./schema.sql yb-tserver-n1:/home/yugabyte/.


docker exec -it yb-tserver-n1 sh -c "[[ -d /home/yugabyte/data ]] || mkdir /home/yugabyte/data"

docker cp ./data/orders.sql yb-tserver-n1:/home/yugabyte/data/.
docker cp ./data/products.sql yb-tserver-n1:/home/yugabyte/data/.
docker cp ./data/reviews.sql yb-tserver-n1:/home/yugabyte/data/.
docker cp ./data/users.sql yb-tserver-n1:/home/yugabyte/data/.





echo docker exec -it yb-tserver-n1 /home/yugabyte/bin/ysqlsh -h yb-tserver-n1  --echo-queries
echo "CREATE DATABASE yb_demo;"
echo '\c yb_demo;'
echo "\i 'schema.sql';"
echo "\i 'data/products.sql'"
echo "\i 'data/users.sql'"
echo "\i 'data/orders.sql'"
echo "\i 'data/reviews.sql'"
echo "\d products"

echo "SELECT count(*) FROM products;"

echo "SELECT id, title, category, price, rating
          FROM products
          LIMIT 5;"

echo "SELECT id, title, category, price, rating
          FROM products
          LIMIT 3 OFFSET 5;"

echo "SELECT users.id, users.name, users.email, orders.id, orders.total
          FROM orders INNER JOIN users ON orders.user_id=users.id
          LIMIT 10;"

echo "BEGIN TRANSACTION;

/* First insert a new order into the orders table. */
INSERT INTO orders
  (id, created_at, user_id, product_id, discount, quantity, subtotal, tax, total)
VALUES (
  (SELECT max(id)+1 FROM orders)                 /* id */,
  now()                                          /* created_at */,
  1                                              /* user_id */,
  2                                              /* product_id */, 
  0                                              /* discount */,
  10                                             /* quantity */,
  (10 * (SELECT price FROM products WHERE id=2)) /* subtotal */,
  0                                              /* tax */,
  (10 * (SELECT price FROM products WHERE id=2)) /* total */
) RETURNING id;

/* Next decrement the total quantity from the products table. */
UPDATE products SET quantity = quantity - 10 WHERE id = 2;

COMMIT;"


echo "select * from orders where id = (select max(id) from orders);"

echo "SELECT DISTINCT(source) FROM users;"






