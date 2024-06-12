-- 1)gmail.com uzantılı kaç müşteri var?
select count(*) from musteriler where email like "%gmail.com"


-- 2)Ibm pc ürününü alan kişilerin adları ve soyadları nelerdir?
SELECT m.ad,m.soyad FROM musteriler m
INNER JOIN satis s on m.m_no = s.m_no 
INNER JOIN  satis_detay sd ON  s.s_no = sd.s_no
INNER JOIN urunler u ON sd.u_no = u.u_no
where u.ad = "Ibm pc";
-- join kullanmadan 
select m.ad, m.soyad 
from musteriler m, satis s, satis_detay sd, urunler u
where m.m_no=s.m_no and s.s_no=sd.s_no and sd.u_no=u.u_no and u.ad="Ibm pc";
-- nested query ile 
SELECT m.ad,m.soyad FROM musteriler m where m.m_no in
(Select s.m_no from satis s where s.s_no in
(select  sd.s_no from satis_detay as sd where sd.u_no =
(select  u.u_no from urunler u where u.ad = "Ibm pc")));


-- 3) 2 adet alışveriş yapan kişilerin adları ve soyadları nelerdir?
-- join kullanarak
SELECT m.ad,m.soyad FROM musteriler m
INNER JOIN   satis s ON m.m_no = s.m_no 
INNER JOIN satis_detay sd ON s.s_no = sd.s_no
where sd.miktar = 2;
-- tablo kullanarak 
SELECT m.ad,m.soyad FROM musteriler m, satis s, satis_detay sd
where m.m_no = s.m_no and s.s_no = sd.s_no and sd.miktar = 2;
-- nested query kullanarak 
SELECT m.ad,m.soyad FROM musteriler m where m.m_no in
(SELECT s.m_no from satis s where s.s_no in 
(select sd.s_no from satis_detay sd where sd.miktar = 2));


-- 4) Her kategori altındaki ürünlerin ortalama fiyatı ne kadardır?
-- join kullanarak
SELECT  k.ad, avg(fiyat) from urunler u 
INNER JOIN kategoriler k ON k.k_no = u.k_no
group by k.ad;
-- tablo birleştirme ile 
SELECT  k.ad, avg(fiyat) from urunler u ,kategoriler k
where k.k_no = u.k_no 
group by k.ad;


-- 5) Parasal olarak en çok alışveriş yapan kişilerin adları ve soyadları nelerdir?
-- join kullanarak
SELECT * FROM musteriler m 
INNER JOIN satis s on m.m_no = s.m_no
order by s.t_fiyat desc 
limit 1 ;
-- nested query 
SELECT * from musteriler m where m.m_no  =
(SELECT s.m_no from satis s order by s.t_fiyat desc limit 1);


-- 6) Her üründen kaç liralık stok vardır ? 
-- join kullanarak
SELECT u.ad, (u.fiyat * u.stok) as total from urunler u 
INNER JOIN kategoriler k ON u.k_no = k.k_no;
-- tablo birleştirme ile 
SELECT u.ad, (u.fiyat * u.stok) from urunler u, kategoriler k where u.k_no = k.k_no;


-- 7. Her kategori isminde kaç ürün vardır?
SELECT u.ad, u.stok from urunler u 
INNER JOIN kategoriler k ON u.k_no = k.k_no;
-- tablo birleştirme ile 
SELECT u.ad, u.stok from urunler u, kategoriler k where u.k_no = k.k_no;


-- 8. Her kategori isminde toplam kaç liralık ürün vardır?
SELECT  k.ad, sum(u.fiyat) as total from urunler u 
INNER JOIN kategoriler k ON u.k_no = k.k_no
group by u.k_no;
-- tablo birleştirme ile 
select k.ad, sum(fiyat) from urunler u, kategoriler k where u.k_no=k.k_no group by k.ad


-- 9. En ucuz ürünü satın alan müşterinin adları ve soyadları nelerdir?
-- join kullanarak
SELECT * from musteriler m 
INNER JOIN satis s ON m.m_no = s.m_no
INNER JOIN satis_detay sd ON s.s_no = sd.s_no
INNER JOIN urunler u ON u.u_no = sd.u_no
order by u.fiyat asc limit 1;
-- Tablo ile çözümü 
SELECT * from musteriler m , satis s  , satis_detay sd , urunler u 
where m.m_no = s.m_no  and s.s_no = sd.s_no and u.u_no = sd.u_no 
order by u.fiyat asc limit 1;
-- nested query ile çözümü 4 select kullanılacak 
SELECT * from musteriler m where m.m_no =
(SELECT  s.m_no from satis s where s.s_no = 
(SELECT sd.s_no from satis_detay sd where sd.u_no = 
(Select u.u_no from urunler u order by u.fiyat asc limit 1)));


--10) Müşterilerin bulundukları şehir adlarına göre kaçar adet satın alma olmuştur?
-- Join ile 
SELECT m.sehir , count(*) from musteriler m 
INNER JOIN satis s ON m.m_no = s.m_no
group by m.sehir ;

-- Tablolar 
select m.sehir, count(*) from musteriler m, satis s where s.m_no=m.m_no group by m.sehir;


-- 11) Şehir adı bazında toplam satınalma tutarları ne kadardır?
-- join kullanarak
SELECT m.sehir, sum(s.t_fiyat) from musteriler m 
INNER JOIN satis s ON m.m_no = s.m_no
group by m.sehir ;
-- Tablo kullanılarak 
select m.sehir, sum(s.t_fiyat) from satis s, musteriler m 
where s.m_no=m.m_no 
group by m.sehir;


--12) Mahmut Özdemir adlı kişinin yaptığı alışverişin satış detay bilgilerini listeleyin.
-- join kullanarak
SELECT *  from musteriler m 
INNER JOIN satis s ON m.m_no = s.m_no
INNER JOIN satis_detay sd ON s.s_no = sd.s_no
where m.ad ="Mahmut" and m.soyad = "Özdemir";
-- Tablo kullanılarak 
select sd.* from satis_detay sd, musteriler m, satis s
where sd.s_no=s.s_no and s.m_no=m.m_no and m.ad="Mahmut" and m.soyad="Özdemir";
-- nested query ile 
SELECT * from satis_detay sd where sd.s_no = 
(select  s.s_no from satis s  where s.m_no = 
(select m.m_no from musteriler m 
where m.ad ="Mahmut" and m.soyad = "Özdemir"));


--13) 5' ten fazla ürün olan kategori numaralarını ve ürün sayılarını listele
-- join kullanarak
SELECT k.k_no , count(u_no) as urun_sayısı from kategoriler k
INNER JOIN urunler u ON u.k_no = k.k_no
group by u.k_no having urun_sayısı >= 5;
-- Tablo 
Select k_no, count(u_no) from urunler group by k_no having count(u_no)>=5;


-- 14) Sony kelimesi içeren ürünlerin kategori adı nedir?
-- join kullanarak
SELECT k.ad FROM kategoriler k 
INNER JOIN urunler u ON u.k_no = k.k_no 
where u.ad like "%sony%";
-- nested query kullanarak 
select k.ad from kategoriler k 
where k_no in
(select k_no from urunler where ad like '%sony%');


-- 15) En çok ürün çeşidinin bulunduğu kategorilerin isimleri nelerdir?
-- tablo ile çözümü 
select k.ad from urunler u, kategoriler k where k.k_no=u.k_no group by u.k_no order by
count(*) desc limit 1;
-- iç içe select ile çözümü
select ad from kategoriler where k_no= (select k_no from urunler group by k_no order by
count(*) desc limit 1);

-- 18) Her kategorideki en pahalı ürünü alan müşterinin ad, soyad ve emailini listeleyiniz.
-- join kullanarak 
SELECT m.ad, m.soyad, m.email 
FROM musteriler m
INNER JOIN satis s ON m.m_no = s.m_no
INNER JOIN satis_detay sd ON s.s_no = sd.s_no
INNER JOIN urunler u ON sd.u_no = u.u_no
INNER JOIN (
    SELECT k_no, MAX(fiyat) as max_fiyat
    FROM urunler
    GROUP BY k_no
) as max_fiyat_urunler ON u.k_no = max_fiyat_urunler.k_no AND u.fiyat = max_fiyat_urunler.max_fiyat;

-- iç içe select ile 
select ad,soyad,email from musteriler where m_no in(
select m_no from satis where s_no in( select s_no from satis_detay where u_no in(
select u_no from urunler where fiyat in( select max(fiyat) from urunler
group by k_no ))));

-- burada kaldım 
-- 19) 3 nolu kategoride bulunan ürünler içerisinde en az miktarda stok bulunan ürünlerin
adlarını ve ürün numarasını bulunuz.
select u.ad, u.u_no from urunler u, kategoriler k
where u.k_no=k.k_no and stok=(select min(stok) from urunler u, kategoriler k
where u.k_no=k.k_no) and k.k_no=3


-- 20) Fiyatı 300 ile 2000 arasında olan ürünleri satın alan müşterilerden hotmail kullanan müşterilerin isimlerini ve email adreslerini listeleyiniz.
select m.ad,m.email from musteriler m,satis s 
where m.m_no=s.m_no and email like
'%hotmail%' and s.s_no in
(select s_no from satis_detay where u_no in
(select u_no from urunler where fiyat between 300 and 2000));


-- 21. En fazla miktarda satılan ürünün kategori adı nedir?
-- join 
SELECT k.ad from kategoriler k
INNER JOIN urunler u ON  k.k_no = u.k_no
INNER JOIN satis_detay sd ON sd.u_no = u.u_no where u.u_no =
(select u_no from satis_detay order by miktar desc limit 1 );

-- nested 
select ad from kategoriler
where k_no in (select k_no from urunler where u_no in (select u_no from satis_detay where
miktar in(select max(miktar) from satis_detay)));


-- Tüm ürünlerin ortalama fiyatından daha düşük fiyata sahip olan ürünleri alan müşteri numaralarını ve adlarını listeleyiniz.
-- (Her bir müşteri bilgisi sadece 1 defa listelenecektir.) 
-- Çözüm 1:
select distinct(m.m_no), m.ad from urunler u, satis_detay sd, satis s, musteriler m
where u.u_no=sd.u_no and sd.s_no=s.s_no and s.m_no=m.m_no 
and fiyat < (select avg(fiyat) from urunler u);
-- Çözüm 2
select m_no,ad from musteriler
where m_no in (select m_no from satis where s_no in (select s_no from satis_detay
where u_no in (select u_no from urunler where fiyat<(select avg(fiyat) from urunler))));
-- Çözüm 3:
select distinct(m.m_no),m.ad from musteriler m, satis s,satis_detay sd
where m.m_no=s.m_no and s.s_no=sd.s_no and sd.u_no in
(select u_no from urunler where fiyat<(select avg(fiyat) from urunler));


-- Fiyatı 500 liradan fazla olan ürünleri satın alan musterilerin yaşadığı yerlere göre kaç adet olduğunu bulunuz
select sehir,count(*) from musteriler
 where m_no in 
 (select m_no from satis where s_no in 
	(select s_no from satis_detay where u_no in
		(select u_no from urunler where fiyat>500))) group by sehir;


-- Maili hotmail.com ile biten müşterilerin aldığı ürünlerin numaralarını ve kaç adet aldıklarını listeleyiniz.
select u.u_no , count(*) from satis_detay sd, urunler u
where sd.u_no=u.u_no and sd.s_no in 
(select s_no from satis where m_no in 
	(select m_no from musteriler 
    where email like '%hotmail.com%')) 
 group by u.u_no;
-- Toplam satış adeti en yüksek olan ürünü alan kişilerin listesi
select m.* from satis s, satis_detay sd, musteriler m
where m.m_no = s.m_no and sd.s_no = s.s_no and sd.u_no =( select u_no from satis_detay
where miktar = (select max(miktar) from satis_detay));

-- Isparta veya İstanbul'da kayıtlı olan müşterilerden bilgisayar kategorisindeki ürünlerden satın alanların müşteri numarası, ad ve soyadı listeleyiniz.
select m.* from musteriler m
where m_no in
(select m_no from satis s where s_no in 
	(select s_no from satis_detay where u_no in
		(select u_no from urunler where k_no in 
			(select k_no from kategoriler 
				where ad="bilgisayar"))) and sehir="ısparta" or sehir="istanbul");