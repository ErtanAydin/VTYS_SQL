/*Database Olu�turulma A�amas�*/
Create Database DijitalOyun 
GO

Use DijitalOyun

CREATE TABLE Aittir(
	Aitlik_id int NOT NULL PRIMARY KEY,
	Kategori_id int NOT NULL,
	Oyun_id int NOT NULL,
)
GO

CREATE TABLE Kullan�c�(
	Kullan�c�_id int NOT NULL PRIMARY KEY,
	Email varchar(20) NULL,
	�ifre varchar(20) NOT NULL,
	Level int NOT NULL,
	HesapDurumu bit NOT NULL,
	C�zdanTutar� bigint NULL,
)
GO

CREATE TABLE �stek_Listesi(
	istekliste_id int NOT NULL PRIMARY KEY,
	Oyun_say�s� int NULL,
	Kullan�c�_id int NULL FOREIGN KEY REFERENCES Kullan�c�(Kullan�c�_id),
)
GO

CREATE TABLE Geli�tirici(
	Geli�tirici_id int NOT NULL PRIMARY KEY,
	Geli�tirici_Ciro bigint NULL,
	Geli�tirici_isim varchar(30) NULL,
)
GO

CREATE TABLE Yay�nc�(
	Yay�nc�_id int NOT NULL PRIMARY KEY,
	Yay�nc�_Ciro bigint NULL,
	Yay�nc�_isim varchar(30) NULL,
)
GO

CREATE TABLE Oyun(
	Oyun_id int NOT NULL PRIMARY KEY,
	��k��_Tarihi date NULL,
	Oyun_ismi varchar(50) NULL,
	Oyun_fiyat� int NOT NULL,
	Geli�tirici_id int FOREIGN KEY REFERENCES Geli�tirici(Geli�tirici_id),
	Yay�nc�_id int FOREIGN KEY REFERENCES Yay�nc�(Yay�nc�_id),
)
GO

CREATE TABLE Ba�ar�m(
	Ba�ar�m_id int NOT NULL PRIMARY KEY,
	Ba�ar�m_isim nvarchar(30) NOT NULL,
	Oyun_id int FOREIGN KEY REFERENCES Oyun(Oyun_id),
)

GO

CREATE TABLE Ba�ar�r(
	Ba�arma_id int NOT NULL PRIMARY KEY,
	Ba�ar�m_Tarihi datetime NOT NULL,
	Kullan�c�_id int FOREIGN KEY REFERENCES Kullan�c�(Kullan�c�_id),
	Ba�ar�m_id int FOREIGN KEY REFERENCES Ba�ar�m(Ba�ar�m_id),
)
GO

CREATE TABLE �stek(
	istek_id int NOT NULL PRIMARY KEY,
	Kabul_Red bit NULL,
	Tarih_Saat datetime NOT NULL,
	Kullan�c�1_id int FOREIGN KEY REFERENCES Kullan�c�(Kullan�c�_id),
	Kullan�c�2_id int FOREIGN KEY REFERENCES Kullan�c�(Kullan�c�_id),
)
GO

CREATE TABLE Bulundurur(
	Bulundurma_id int NOT NULL PRIMARY KEY,
	Oyun_id int FOREIGN KEY REFERENCES Oyun(Oyun_id),
	istek_id int FOREIGN KEY REFERENCES �stek_Listesi(istekliste_id),
)
GO

CREATE TABLE �tem(
	item_id int NOT NULL PRIMARY KEY,
	item_isim nvarchar(50) NOT NULL,
	Oyun_id int FOREIGN KEY REFERENCES Oyun(Oyun_id),
)
GO

CREATE TABLE Envanter_kayd�(
	Envanter_id int NOT NULL PRIMARY KEY,
	Sat��taM� bit NOT NULL,
	Al��_Tarihi date NOT NULL,
	Aktif bit NOT NULL,
	Sat��_Tarihi date NOT NULL,
	Sat��_fiyat� float NOT NULL,
	Al��_fiyat� float NOT NULL,
	Kullan�c�_id int FOREIGN KEY REFERENCES Kullan�c�(Kullan�c�_id),
	�tem_id int FOREIGN KEY REFERENCES �tem(�tem_id),
)
GO

CREATE TABLE Kategori(
	Kategori_id int NOT NULL PRIMARY KEY,
	Kategori_isim varchar(20) NULL,
	Oyun_Say�s� nchar(10) NULL,
)
GO

CREATE TABLE Kopya(
	Seri_no int NOT NULL PRIMARY KEY,
	Kopya_tarihi date NOT NULL,
	Kullan�c�_id int FOREIGN KEY REFERENCES Kullan�c�(Kullan�c�_id),
	Oyun_id int FOREIGN KEY REFERENCES Oyun(Oyun_id),
)
GO

CREATE TABLE Teklif(
	Teklif_id int NOT NULL PRIMARY KEY,
	Miktar int NOT NULL,
	Envanter_id int FOREIGN KEY REFERENCES Envanter_kayd�(Envanter_id),
	Kullan�c�_id int FOREIGN KEY REFERENCES Kullan�c�(Kullan�c�_id),
)
GO

CREATE TABLE Yorum(
	Yorum_id int NOT NULL,
	Be�eni int NULL,
	Pozitif_Negatif bit NULL,
	Yorum_Tarihi datetime NULL,
	Kullan�c�_id int  FOREIGN KEY REFERENCES Kullan�c�(Kullan�c�_id),
	Oyun_id int FOREIGN KEY REFERENCES Oyun(Oyun_id),
)
GO

