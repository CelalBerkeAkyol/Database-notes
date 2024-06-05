--# tablolar 
-- - bolumler 
-- - dersler
-- - fakulteler
-- - notlar
-- - ogrenciler
-- Her öğrencinin adı, soyadı, aldığı ders kodu ve vize notlarının listelenmesi
SELECT o.ograd, o.ogrsoyad, n.derskodu, n.vize 
FROM ogrenciler o 
RIGHT JOIN notlar n
ON o.ogrno = n.ogrno;
--Vize notu olmayan(girilmeyen) öğrencilerin adları ve soyadlarının listesi
SELECT * 
FROM ogrenciler o
LEFT JOIN notlar n
on o.ogrno = n.ogrno
where n.vize is null; 
-- Vize notu olmayan(girilmeyen) kız öğrenciler kaç kişidir?
SELECT count(*) as kız_sayısı
FROM ogrenciler o 
LEFT JOIN notlar n
ON o.ogrno = n.ogrno
where n.vize is null and o.cinsiyet = "bayan";
--Her bir cinsiyete göre vize notu olmayan(girilmeyen) öğrenci sayılarını bulunuz.
SELECT o.cinsiyet, count(*)
FROM ogrenciler o 
LEFT JOIN notlar n 
ON o.ogrno = n.ogrno 
WHERE n.vize is null
group by o.cinsiyet;
--Resim bölümündeki öğrencilerin final not ortalamaları kaçtır?
SELECT avg(final)
FROM ogrenciler o 
INNER JOIN notlar n  ON o.ogrno = n.ogrno 
INNER JOIN bolumler b on o.bolumkod = b.bolumno
WHERE b.bolumad = "Resim";
--Dersin adı, o dersteki en yüksek ve ortalama vizeyi listeleyiniz.
SELECT d.dersadi,avg(vize) as ortalama, max(vize) as en_yuksek
FROM notlar n  
INNER JOIN dersler d
ON n.derskodu = d.derskodu
group by d.dersadi;
-- 30 nolu derste ortalama vize ve finalden daha yüksek not alan erkek öğrencilerin ad, soyad
ve bölüm adlarının listesi
SELECT o.ograd,o.ogrsoyad,b.bolumad from ogrenciler o
INNER JOIN notlar n ON o.ogrno = n.ogrno 
INNER join bolumler b ON o.bolumkod = b.bolumno 
where n.derskodu = 30 and vize > (SELECT avg(vize) from notlar) and final > (Select avg(final) from notlar ) and o.cinsiyet = "erkek";
