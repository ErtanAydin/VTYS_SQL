
-- Yayýncýlarýn Ciro deðerleri güncellenmiþtir--

UPDATE Yayýncý SET Ciro=Ciro + 10000 where isim = 'Sony Interactive Entertainment'
UPDATE Yayýncý SET Ciro=Ciro - 5000 where isim = 'Telltale Games'
UPDATE Yayýncý SET Ciro=10000 where isim = 'Microsoft'
UPDATE Yayýncý SET Ciro=Ciro + Ciro*0.1 where isim = 'Konami' or isim = 'EA'
--Tüm Cirolar azaltýlmýþtýr
UPDATE Yayýncý SET Ciro=Ciro - Ciro*0.1


-- Geliþtiricilerin Ciro deðerleri güncellenmiþtir--

UPDATE Gelýþtirici SET Ciro=Ciro + 5000 where isim = 'Ubisoft'
UPDATE Gelýþtirici SET Ciro=Ciro - 20000 where isim = 'Paradox Interactive'
UPDATE Gelýþtirici SET Ciro=80000 where isim = 'Activision'
UPDATE Gelýþtirici SET Ciro=Ciro - Ciro*0.1 where isim = 'Nintendo' or isim = 'Bioware'
--Tüm Cirolar arttýrýlmýþtýr--
UPDATE Gelýþtirici SET Ciro=Ciro + Ciro*0.2

-- Kategorilerdeki oyun sayýlarý güncellenmiþtir--
UPDATE Kategori SET Oyun_Sayýsý = Oyun_Sayýsý + 1000 where isim = 'Macera'
UPDATE Kategori SET Oyun_Sayýsý = Oyun_Sayýsý - 500 where isim = 'Simulasyon'
UPDATE Kategori SET Oyun_Sayýsý = 8000 where isim = 'Platform'


--Kullanýcýnýn cüzdan tutarý arttýrýlmýþtýr--
UPDATE Kullanýcý SET Cüzdantutarý = Cüzdantutarý + 50 where Email = 'b@hotmail.com'
--Kullanýcýnýn leveli arttýrýlmýþtýr--
UPDATE Kullanýcý SET Level = Level + 1 where Email = 'e@hotmail.com'
-- Kullanýcýnýn hesap durumu güncellenmiþtir--
UPDATE Kullanýcý SET HesapDurumu = 1 where Email = 's@hotmail.com'
-- Kullanýcýnýn þifresi deðiþtirilmiþtir--
UPDATE Kullanýcý SET Pass = 'M' where Email = 'q@hotmail.com'
-- Kullanýcýnýn emaili güncellenmiþtir--
UPDATE Kullanýcý SET Email = 'z@hotmail.com' where Cüzdantutarý = 40 and Level=100


-- Ýstek listelerindeki oyun sayýlarý güncellenmiþtir--
UPDATE Ýstek_listesi SET Oyun_sayýsý = 5 where Kullanýcý_ýd = 3
UPDATE Ýstek_listesi SET Oyun_sayýsý = Oyun_sayýsý - 1 where Kullanýcý_ýd = 7
UPDATE Ýstek_listesi SET Oyun_sayýsý = Oyun_sayýsý + 3 where Kullanýcý_ýd = 2
UPDATE Ýstek_listesi SET Oyun_sayýsý = 0 where Kullanýcý_ýd = 5



-- Yorumlarýn beðeni sayýlarý güncellenmiþtir--
UPDATE Yorum SET Beðeni = Beðeni + 5 where Kullanýcý_ýd = 6
UPDATE Yorum SET Beðeni = Beðeni - 1 where [Tarih-saat] = '20090804 10:34:09 AM'
-- Yorumlarýn pozitif negatif olma durumu güncellenmiþtir--
UPDATE Yorum SET [Pozitif-negatif] = 0 where Kullanýcý_ýd = 2
UPDATE Yorum SET [Pozitif-negatif] = 1 where Kullanýcý_ýd = 8

-- Baþarým isimleri deðiþtirilmiþtir--
UPDATE Baþarým SET isim = 'z' where Oyun_ýd = 10
UPDATE Baþarým SET isim = 'L' where Oyun_ýd = 1

-- Envanter aktif hale getirilmiþtir--
UPDATE Envanter_kaydý SET Aktif = 1 where Kullanýcý_ýd = 2
-- Envanterdeki ürünün alýþ fiyatý deðiþtirilmiþtir--
UPDATE Envanter_kaydý SET Alýþ_fiyatý =250 where Kullanýcý_ýd = 9
-- Envanterdeki ürünün satýþ fiyatý deðiþtirilmiþtir--
UPDATE Envanter_kaydý SET Satýþ_fiyatý =300 where Kullanýcý_ýd = 5
-- Envanterdeki ürün satýþta haline getirilmiþtir--
UPDATE Envanter_kaydý SET Satýþtamý = 1 where Kullanýcý_ýd = 7


--Oyunlarýn isimlerinde ve çýkýþ tarihlerinde düzeltmeler yapýlmýþtýr--

UPDATE Oyun SET Ýsmi= 'Crusader Kings' where Çýkýþ_Tarihi = '20120506'
UPDATE Oyun SET Ýsmi= 'The Wolf Among Us' where Çýkýþ_Tarihi = '20160506'
UPDATE Oyun SET Çýkýþ_Tarihi = '20181008' where  Ýsmi = 'The Crew 2'
UPDATE Oyun SET Çýkýþ_Tarihi = '20150702' where  Ýsmi = 'NBA 2K'
UPDATE Oyun SET Çýkýþ_Tarihi = '20100112' where  Ýsmi = 'Gears of War'


-- Teklif miktarý deðiþtirilmiþtir--
UPDATE Table_1 SET Miktar= '250' where Kullanýcý_ýd = 2