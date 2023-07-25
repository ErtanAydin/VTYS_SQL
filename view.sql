/*Oluþturulacak nesnenin veritabanýnda var olup olmadýðýný  kontrol eden varsa silen kod bölümü.*/
IF OBJECT_ID('dbo.view_Kullanici_istekListesi_detayli') IS NOT NULL BEGIN DROP VIEW view_Kullanici_istekListesi_detayli END 
GO 

CREATE VIEW view_Kullanici_istekListesi_detayli
AS
	SELECT        K.Kullanýcý_id as "Kullanýcý ID", K.Email as "E-mail", K.CüzdanTutarý as "Cüzdan Tutarý",
				  CASE WHEN K.CüzdanTutarý<=50 THEN 'Düþük'
					   WHEN K.CüzdanTutarý<=200 THEN 'Orta'
					   ELSE 'Yüksek'
				  END AS BÜTÇE,
				  CASE WHEN K.HesapDurumu=0 THEN 'Pasif'
					   ELSE 'Aktif'
				  END AS "Hesap Durumu",
				  O.Oyun_id  as "Oyun ID", O.Oyun_ismi  as "Oyun Ýsmi",YEAR(O.Çýkýþ_Tarihi) as "Çýkýþ Tarihi", O.Oyun_fiyatý  as "Oyun Fiyatý",
				  O.Geliþtirici_id as "Geliþtirici ID", O.Yayýncý_id as "Yayýncý ID"
	FROM            Bulundurur B INNER JOIN
							 Oyun O ON B.Oyun_id = O.Oyun_id INNER JOIN
							 Ýstek_Listesi L ON B.istek_id = L.istekliste_id INNER JOIN
							 Kullanýcý K ON L.Kullanýcý_id = K.Kullanýcý_id
GO

/* Geliþtirici, hangi kullanýcýlarýn istek listesinde geliþtiricinin kendi oyununu isteyip buna parasýnýn yettiðini görebilecek bir view ister.
   Bu amaçla parasý yeten kullanýcýlara reklam verilebilir. */

SELECT "Kullanýcý ID","Cüzdan Tutarý","Hesap Durumu","Oyun Ýsmi","Oyun Fiyatý",G.Geliþtirici_isim as "Geliþtirici Ýsmi"
FROM view_Kullanici_istekListesi_detayli V INNER JOIN Geliþtirici G on V."Geliþtirici ID"=G.Geliþtirici_id
WHERE "Oyun Fiyatý" < "Cüzdan Tutarý" AND G.Geliþtirici_isim='Nintendo'
ORDER BY "Oyun Fiyatý"

/*  Ýstek listesindeki oyunu satýn alabilecek kadar bakiyesi olan kullanýcýlar ve detaylarý view ile verilir. */

SELECT "Kullanýcý ID","Cüzdan Tutarý","Hesap Durumu","Oyun Ýsmi","Oyun Fiyatý",G.Geliþtirici_isim as "Geliþtirici Ýsmi", Y.Yayýncý_isim as "Yayýncý Ýsmi"
FROM view_Kullanici_istekListesi_detayli V INNER JOIN Geliþtirici G on V."Geliþtirici ID"=G.Geliþtirici_id INNER JOIN Yayýncý Y on Y.Yayýncý_id="Yayýncý ID"
WHERE "Oyun Fiyatý" < "Cüzdan Tutarý"
ORDER BY "Oyun Fiyatý"