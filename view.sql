/*Olu�turulacak nesnenin veritaban�nda var olup olmad���n�  kontrol eden varsa silen kod b�l�m�.*/
IF OBJECT_ID('dbo.view_Kullanici_istekListesi_detayli') IS NOT NULL BEGIN DROP VIEW view_Kullanici_istekListesi_detayli END 
GO 

CREATE VIEW view_Kullanici_istekListesi_detayli
AS
	SELECT        K.Kullan�c�_id as "Kullan�c� ID", K.Email as "E-mail", K.C�zdanTutar� as "C�zdan Tutar�",
				  CASE WHEN K.C�zdanTutar�<=50 THEN 'D���k'
					   WHEN K.C�zdanTutar�<=200 THEN 'Orta'
					   ELSE 'Y�ksek'
				  END AS B�T�E,
				  CASE WHEN K.HesapDurumu=0 THEN 'Pasif'
					   ELSE 'Aktif'
				  END AS "Hesap Durumu",
				  O.Oyun_id  as "Oyun ID", O.Oyun_ismi  as "Oyun �smi",YEAR(O.��k��_Tarihi) as "��k�� Tarihi", O.Oyun_fiyat�  as "Oyun Fiyat�",
				  O.Geli�tirici_id as "Geli�tirici ID", O.Yay�nc�_id as "Yay�nc� ID"
	FROM            Bulundurur B INNER JOIN
							 Oyun O ON B.Oyun_id = O.Oyun_id INNER JOIN
							 �stek_Listesi L ON B.istek_id = L.istekliste_id INNER JOIN
							 Kullan�c� K ON L.Kullan�c�_id = K.Kullan�c�_id
GO

/* Geli�tirici, hangi kullan�c�lar�n istek listesinde geli�tiricinin kendi oyununu isteyip buna paras�n�n yetti�ini g�rebilecek bir view ister.
   Bu ama�la paras� yeten kullan�c�lara reklam verilebilir. */

SELECT "Kullan�c� ID","C�zdan Tutar�","Hesap Durumu","Oyun �smi","Oyun Fiyat�",G.Geli�tirici_isim as "Geli�tirici �smi"
FROM view_Kullanici_istekListesi_detayli V INNER JOIN Geli�tirici G on V."Geli�tirici ID"=G.Geli�tirici_id
WHERE "Oyun Fiyat�" < "C�zdan Tutar�" AND G.Geli�tirici_isim='Nintendo'
ORDER BY "Oyun Fiyat�"

/*  �stek listesindeki oyunu sat�n alabilecek kadar bakiyesi olan kullan�c�lar ve detaylar� view ile verilir. */

SELECT "Kullan�c� ID","C�zdan Tutar�","Hesap Durumu","Oyun �smi","Oyun Fiyat�",G.Geli�tirici_isim as "Geli�tirici �smi", Y.Yay�nc�_isim as "Yay�nc� �smi"
FROM view_Kullanici_istekListesi_detayli V INNER JOIN Geli�tirici G on V."Geli�tirici ID"=G.Geli�tirici_id INNER JOIN Yay�nc� Y on Y.Yay�nc�_id="Yay�nc� ID"
WHERE "Oyun Fiyat�" < "C�zdan Tutar�"
ORDER BY "Oyun Fiyat�"