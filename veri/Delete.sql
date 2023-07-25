
-- Telltale Games yay�nc�lardan silinmi�tir--

DELETE FROM Yay�nc� where isim = 'Telltale Games'

-- Deep Silver geli�tiricilerden silinmi�tir--

DELETE FROM Gel��tirici where isim = 'Deep Silver'

-- Early Access kategorilerden silinmi�tir--

DELETE FROM Kategori where isim = 'Early Access'

-- 20160506 da ��kan oyunlar silinmi�tir--

DELETE FROM OYUN where ��k��_Tarihi = '20160506'

-- COD MW2 oyunundaki itemler silinmi�tir--

DELETE FROM �tem where Oyun_�d = 3

-- Hesap durumu banlanm�� olan oyuncular�n hesaplar� silinmi�tir --

DELETE FROM Kullan�c� where HesapDurumu = 1

-- ��inde oyun bulunmayan istek listeleri silinmi�tir --

DELETE FROM �stek_listesi where Oyun_say�s� = 0

-- Silinen oyuna ait kopyalar silinmi�tir--

DELETE FROM KOPYA where Oyun_�d = 4

-- Negatif yorumlar silinmi�tir--

DELETE FROM Yorum where [Pozitif-negatif] = 0

-- Silinen oyuna ait ba�ar�mlar silinmi�tir--

DELETE FROM Ba�ar�m where Oyun_�d = 4

-- Reddedilen istekler silinmi�tir--

DELETE FROM �stek where [Kabul-ret] = 0

-- Aktif olmayan envanter kay�tlar� silinmi�tir--

DELETE FROM Envanter_kayd� where Aktif = 0

-- Silinen ba�ar�mlara ait bilgiler silinmi�tir--

DELETE FROM Ba�ar�r where Ba�ar�m_�d = 4

-- Miktar� 300 den k���k olan teklifler silinmi�tir--

DELETE FROM Table_1 where Miktar < 300