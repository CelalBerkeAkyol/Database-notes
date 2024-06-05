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
USE northwind;
SELECT  o.shipper_id, s.company, sum(o.shipping_fee) as total
FROM orders as o
INNER JOIN shippers as s
ON o.shipper_id = s.id
group by s.id
order by total desc;
--'2', 'Shipping Company B', '1580.0000'
--'3', 'Shipping Company C', '338.0000'
--'1', 'Shipping Company A', '220.0000'

-- En uygun kargo ücreti hangisidir ? 
SELECT  o.shipper_id, s.company, avg(o.shipping_fee) as ortalama
FROM orders as o
INNER JOIN shippers as s
ON o.shipper_id = s.id
where o.shipping_fee > 0
group by s.id
order by ortalama desc;
--'2', 'Shipping Company B', '87.77777778'
--'1', 'Shipping Company A', '36.66666667'
--'3', 'Shipping Company C', '28.16666667'
