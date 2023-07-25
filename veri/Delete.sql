
-- Telltale Games yayýncýlardan silinmiþtir--

DELETE FROM Yayýncý where isim = 'Telltale Games'

-- Deep Silver geliþtiricilerden silinmiþtir--

DELETE FROM Gelýþtirici where isim = 'Deep Silver'

-- Early Access kategorilerden silinmiþtir--

DELETE FROM Kategori where isim = 'Early Access'

-- 20160506 da çýkan oyunlar silinmiþtir--

DELETE FROM OYUN where Çýkýþ_Tarihi = '20160506'

-- COD MW2 oyunundaki itemler silinmiþtir--

DELETE FROM Ýtem where Oyun_ýd = 3

-- Hesap durumu banlanmýþ olan oyuncularýn hesaplarý silinmiþtir --

DELETE FROM Kullanýcý where HesapDurumu = 1

-- Ýçinde oyun bulunmayan istek listeleri silinmiþtir --

DELETE FROM Ýstek_listesi where Oyun_sayýsý = 0

-- Silinen oyuna ait kopyalar silinmiþtir--

DELETE FROM KOPYA where Oyun_ýd = 4

-- Negatif yorumlar silinmiþtir--

DELETE FROM Yorum where [Pozitif-negatif] = 0

-- Silinen oyuna ait baþarýmlar silinmiþtir--

DELETE FROM Baþarým where Oyun_ýd = 4

-- Reddedilen istekler silinmiþtir--

DELETE FROM Ýstek where [Kabul-ret] = 0

-- Aktif olmayan envanter kayýtlarý silinmiþtir--

DELETE FROM Envanter_kaydý where Aktif = 0

-- Silinen baþarýmlara ait bilgiler silinmiþtir--

DELETE FROM Baþarýr where Baþarým_ýd = 4

-- Miktarý 300 den küçük olan teklifler silinmiþtir--

DELETE FROM Table_1 where Miktar < 300