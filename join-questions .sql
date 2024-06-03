-- Hangi üründen kaç tane satılmış?? (isim: adet  şeklinde yazdır) 
USE northwind;
SELECT od.id, od.order_id,od.product_id,od.quantity, p.product_name 
FROM products as p
LEFT JOIN order_details as od
ON p.id = od.product_id;
-- En çok kazandıran ilk 3 ürün hangisidir ? ( id, isim, toplam kazanç şeklinde )
SELECT p.id, p.product_name, sum(od.quantity * od.unit_price) as total
FROM products as p
INNER JOIN order_details as od
ON p.id = od.product_id
group by p.id
order by total desc
limit 3;
-- Hangi kargo şirketine en çok ödeme yapılmış ? 
-- En uygun kargo ücreti hangisidir ? 
