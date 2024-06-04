--Vizeden 100 alan öğrencilerin numaraları
select ogrno from notlar where vize =100;
--En yüksek vize notunu alan öğrencilerin numaraları
select ogrno from notlar where vize = (select max(vize) from notlar);
--En yüksek vize notuna sahip öğrencilerin ad ve soyad bilgileri
SELECT o.ograd, o.ogrsoyad where o.ogrno in = 
(select ogrno from notlar where vize = (select max(vize) from notlar));
--En yüksek vize notuna sahip öğrencilerin ad, soyad ve okuduğu bölümlerin isimleri
SELECT o.ograd,o.ogrsoyad, b.bolumad
FROM ogrenciler o, bolumler b
WHERE o.bolumkod=b.bolumno
and o.ogrno in (SELECT ogrno from notlar where vize =(SELECT max(vize) from notlar));
--Tüm dersler içinde, vizesi, ortalama vize notundan yüksek olan öğrencilerin ad soyadları listesi
select * from ogrenciler where ogrno in (select ogrno from notlar where vize >
(select avg(vize) from notlar));
--En yüksek bölüm nolu bölümde okuyan öğrencileri listeleyiniz
select * from ogrenciler o where o.bolumkod = (select b.bolumno from bolumler b order by bolumno desc limit 1);
--En düşük vize notuna sahip öğrencilerin numara, ad ve bölüm adlarını listeleyiniz
select o.ogrno,o.ograd, b.bolumad from ogrenciler o,bolumler b
where o.ogrno in (select ogrno from notlar where vize=(select min(vize) from notlar)) and
b.bolumno=o.bolumkod
--En düşük vize notuna sahip öğrencilerin ad ve bölüm adlarını listeleyiniz (inner join ile çözümü)
SELECT o.ograd,o.ogrsoyad, b.bolumad 
FROM ogrenciler o
INNER JOIN notlar n ON o.ogrno = n.ogrno
INNER JOIN bolumler b ON o.bolumkod = b.bolumno
where o.ogrno = (select ogrno from notlar order by vize asc limit 1);
-- 30 nolu derste vizesi, ortalama vizenin altında kalan öğrencilerin numaraları ve adlarını listeleyin(İçiçe select ile çözünüz)
