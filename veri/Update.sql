
-- Yay�nc�lar�n Ciro de�erleri g�ncellenmi�tir--

UPDATE Yay�nc� SET Ciro=Ciro + 10000 where isim = 'Sony Interactive Entertainment'
UPDATE Yay�nc� SET Ciro=Ciro - 5000 where isim = 'Telltale Games'
UPDATE Yay�nc� SET Ciro=10000 where isim = 'Microsoft'
UPDATE Yay�nc� SET Ciro=Ciro + Ciro*0.1 where isim = 'Konami' or isim = 'EA'
--T�m Cirolar azalt�lm��t�r
UPDATE Yay�nc� SET Ciro=Ciro - Ciro*0.1


-- Geli�tiricilerin Ciro de�erleri g�ncellenmi�tir--

UPDATE Gel��tirici SET Ciro=Ciro + 5000 where isim = 'Ubisoft'
UPDATE Gel��tirici SET Ciro=Ciro - 20000 where isim = 'Paradox Interactive'
UPDATE Gel��tirici SET Ciro=80000 where isim = 'Activision'
UPDATE Gel��tirici SET Ciro=Ciro - Ciro*0.1 where isim = 'Nintendo' or isim = 'Bioware'
--T�m Cirolar artt�r�lm��t�r--
UPDATE Gel��tirici SET Ciro=Ciro + Ciro*0.2

-- Kategorilerdeki oyun say�lar� g�ncellenmi�tir--
UPDATE Kategori SET Oyun_Say�s� = Oyun_Say�s� + 1000 where isim = 'Macera'
UPDATE Kategori SET Oyun_Say�s� = Oyun_Say�s� - 500 where isim = 'Simulasyon'
UPDATE Kategori SET Oyun_Say�s� = 8000 where isim = 'Platform'


--Kullan�c�n�n c�zdan tutar� artt�r�lm��t�r--
UPDATE Kullan�c� SET C�zdantutar� = C�zdantutar� + 50 where Email = 'b@hotmail.com'
--Kullan�c�n�n leveli artt�r�lm��t�r--
UPDATE Kullan�c� SET Level = Level + 1 where Email = 'e@hotmail.com'
-- Kullan�c�n�n hesap durumu g�ncellenmi�tir--
UPDATE Kullan�c� SET HesapDurumu = 1 where Email = 's@hotmail.com'
-- Kullan�c�n�n �ifresi de�i�tirilmi�tir--
UPDATE Kullan�c� SET Pass = 'M' where Email = 'q@hotmail.com'
-- Kullan�c�n�n emaili g�ncellenmi�tir--
UPDATE Kullan�c� SET Email = 'z@hotmail.com' where C�zdantutar� = 40 and Level=100


-- �stek listelerindeki oyun say�lar� g�ncellenmi�tir--
UPDATE �stek_listesi SET Oyun_say�s� = 5 where Kullan�c�_�d = 3
UPDATE �stek_listesi SET Oyun_say�s� = Oyun_say�s� - 1 where Kullan�c�_�d = 7
UPDATE �stek_listesi SET Oyun_say�s� = Oyun_say�s� + 3 where Kullan�c�_�d = 2
UPDATE �stek_listesi SET Oyun_say�s� = 0 where Kullan�c�_�d = 5



-- Yorumlar�n be�eni say�lar� g�ncellenmi�tir--
UPDATE Yorum SET Be�eni = Be�eni + 5 where Kullan�c�_�d = 6
UPDATE Yorum SET Be�eni = Be�eni - 1 where [Tarih-saat] = '20090804 10:34:09 AM'
-- Yorumlar�n pozitif negatif olma durumu g�ncellenmi�tir--
UPDATE Yorum SET [Pozitif-negatif] = 0 where Kullan�c�_�d = 2
UPDATE Yorum SET [Pozitif-negatif] = 1 where Kullan�c�_�d = 8

-- Ba�ar�m isimleri de�i�tirilmi�tir--
UPDATE Ba�ar�m SET isim = 'z' where Oyun_�d = 10
UPDATE Ba�ar�m SET isim = 'L' where Oyun_�d = 1

-- Envanter aktif hale getirilmi�tir--
UPDATE Envanter_kayd� SET Aktif = 1 where Kullan�c�_�d = 2
-- Envanterdeki �r�n�n al�� fiyat� de�i�tirilmi�tir--
UPDATE Envanter_kayd� SET Al��_fiyat� =250 where Kullan�c�_�d = 9
-- Envanterdeki �r�n�n sat�� fiyat� de�i�tirilmi�tir--
UPDATE Envanter_kayd� SET Sat��_fiyat� =300 where Kullan�c�_�d = 5
-- Envanterdeki �r�n sat��ta haline getirilmi�tir--
UPDATE Envanter_kayd� SET Sat��tam� = 1 where Kullan�c�_�d = 7


--Oyunlar�n isimlerinde ve ��k�� tarihlerinde d�zeltmeler yap�lm��t�r--

UPDATE Oyun SET �smi= 'Crusader Kings' where ��k��_Tarihi = '20120506'
UPDATE Oyun SET �smi= 'The Wolf Among Us' where ��k��_Tarihi = '20160506'
UPDATE Oyun SET ��k��_Tarihi = '20181008' where  �smi = 'The Crew 2'
UPDATE Oyun SET ��k��_Tarihi = '20150702' where  �smi = 'NBA 2K'
UPDATE Oyun SET ��k��_Tarihi = '20100112' where  �smi = 'Gears of War'


-- Teklif miktar� de�i�tirilmi�tir--
UPDATE Table_1 SET Miktar= '250' where Kullan�c�_�d = 2