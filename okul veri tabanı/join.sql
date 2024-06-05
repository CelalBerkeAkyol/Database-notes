USE northwind;
-- INNER JOIN: İki tabloyu birleştirirken sadece her iki tabloda da eşleşen kayıtları döndürür.
--Aşağıdaki örnekte customer şeması temel alınarak orders tablosu ile birleştirme yapılır. customer tablosundaki customer.id ile orders tablosundaki cutomer_id aynı olan kişiler sonuç olarak döndürülür 
SELECT  customers.id, customers.first_name, orders.id, orders.customer_id, orders.ship_name
FROM customers
INNER JOIN orders ON customers.id = orders.customer_id;
--İkiden fazla tablonun INNER JOIN ile birleştirilmesi 
SELECT  customers.id as customer_id, customers.first_name, orders.id as order_id, orders.customer_id, orders.ship_name, order_details.product_id
FROM customers
INNER JOIN orders ON customers.id = orders.customer_id
INNER JOIN order_details on order_details.order_id = orders.id;
--LEFT JOIN (LEFT OUTER JOIN): Sol tablodaki tüm kayıtları ve sağ tabloyla eşleşen kayıtları döndürür. Sağ tabloyla eşleşmeyen kayıtlar için NULL değerler döndürülür.
-- customer tablosunda olan fakat order tablosunda olmayan verileri bulmak için left join kullanabiliriz 
SELECT customers.id, customers.first_name, orders.id as order_id, orders.customer_id
FROM customers
LEFT JOIN orders ON	customers.id = orders.customer_id
WHERE orders.id is null;;
-- Cevap olarak dönen sonuçtan id numarsı 19 olan Alexander isimli kullanıcının sipariş oluşturmadığı görülür bu kullanıcıya özel kupon oluşturulup mail atılabilir.
-- ### '19', 'Alexander', NULL, NULL ### 
-- RIGHT JOIN (RIGHT OUTER JOIN): Sağ tablodaki tüm kayıtları ve sol tabloyla eşleşen kayıtları döndürür. Sol tabloyla eşleşmeyen kayıtlar için NULL değerler döndürülür.
SELECT orders.id as order_id, employees.first_name
FROM orders
right JOIN employees 
ON  employees.id = orders.employee_id 
order by orders.id;
-- ## NULL, 'Steven' ##  Steaven hiç satış yapmamış 
--FULL JOIN (FULL OUTER JOIN): Her iki tablodaki tüm kayıtları döndürür. Eşleşen kayıtlar birleştirilir, eşleşmeyenler için NULL değerler döndürülür. (MySQL'de doğrudan desteklenmez, UNION kullanılarak elde edilir.)
