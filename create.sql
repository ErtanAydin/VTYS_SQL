/*Database Oluþturulma Aþamasý*/
Create Database DijitalOyun 
GO

Use DijitalOyun

CREATE TABLE Aittir(
	Aitlik_id int NOT NULL PRIMARY KEY,
	Kategori_id int NOT NULL,
	Oyun_id int NOT NULL,
)
GO

CREATE TABLE Kullanýcý(
	Kullanýcý_id int NOT NULL PRIMARY KEY,
	Email varchar(20) NULL,
	Þifre varchar(20) NOT NULL,
	Level int NOT NULL,
	HesapDurumu bit NOT NULL,
	CüzdanTutarý bigint NULL,
)
GO

CREATE TABLE Ýstek_Listesi(
	istekliste_id int NOT NULL PRIMARY KEY,
	Oyun_sayýsý int NULL,
	Kullanýcý_id int NULL FOREIGN KEY REFERENCES Kullanýcý(Kullanýcý_id),
)
GO

CREATE TABLE Geliþtirici(
	Geliþtirici_id int NOT NULL PRIMARY KEY,
	Geliþtirici_Ciro bigint NULL,
	Geliþtirici_isim varchar(30) NULL,
)
GO

CREATE TABLE Yayýncý(
	Yayýncý_id int NOT NULL PRIMARY KEY,
	Yayýncý_Ciro bigint NULL,
	Yayýncý_isim varchar(30) NULL,
)
GO

CREATE TABLE Oyun(
	Oyun_id int NOT NULL PRIMARY KEY,
	Çýkýþ_Tarihi date NULL,
	Oyun_ismi varchar(50) NULL,
	Oyun_fiyatý int NOT NULL,
	Geliþtirici_id int FOREIGN KEY REFERENCES Geliþtirici(Geliþtirici_id),
	Yayýncý_id int FOREIGN KEY REFERENCES Yayýncý(Yayýncý_id),
)
GO

CREATE TABLE Baþarým(
	Baþarým_id int NOT NULL PRIMARY KEY,
	Baþarým_isim nvarchar(30) NOT NULL,
	Oyun_id int FOREIGN KEY REFERENCES Oyun(Oyun_id),
)

GO

CREATE TABLE Baþarýr(
	Baþarma_id int NOT NULL PRIMARY KEY,
	Baþarým_Tarihi datetime NOT NULL,
	Kullanýcý_id int FOREIGN KEY REFERENCES Kullanýcý(Kullanýcý_id),
	Baþarým_id int FOREIGN KEY REFERENCES Baþarým(Baþarým_id),
)
GO

CREATE TABLE Ýstek(
	istek_id int NOT NULL PRIMARY KEY,
	Kabul_Red bit NULL,
	Tarih_Saat datetime NOT NULL,
	Kullanýcý1_id int FOREIGN KEY REFERENCES Kullanýcý(Kullanýcý_id),
	Kullanýcý2_id int FOREIGN KEY REFERENCES Kullanýcý(Kullanýcý_id),
)
GO

CREATE TABLE Bulundurur(
	Bulundurma_id int NOT NULL PRIMARY KEY,
	Oyun_id int FOREIGN KEY REFERENCES Oyun(Oyun_id),
	istek_id int FOREIGN KEY REFERENCES Ýstek_Listesi(istekliste_id),
)
GO

CREATE TABLE Ýtem(
	item_id int NOT NULL PRIMARY KEY,
	item_isim nvarchar(50) NOT NULL,
	Oyun_id int FOREIGN KEY REFERENCES Oyun(Oyun_id),
)
GO

CREATE TABLE Envanter_kaydý(
	Envanter_id int NOT NULL PRIMARY KEY,
	SatýþtaMý bit NOT NULL,
	Alýþ_Tarihi date NOT NULL,
	Aktif bit NOT NULL,
	Satýþ_Tarihi date NOT NULL,
	Satýþ_fiyatý float NOT NULL,
	Alýþ_fiyatý float NOT NULL,
	Kullanýcý_id int FOREIGN KEY REFERENCES Kullanýcý(Kullanýcý_id),
	Ýtem_id int FOREIGN KEY REFERENCES Ýtem(Ýtem_id),
)
GO

CREATE TABLE Kategori(
	Kategori_id int NOT NULL PRIMARY KEY,
	Kategori_isim varchar(20) NULL,
	Oyun_Sayýsý nchar(10) NULL,
)
GO

CREATE TABLE Kopya(
	Seri_no int NOT NULL PRIMARY KEY,
	Kopya_tarihi date NOT NULL,
	Kullanýcý_id int FOREIGN KEY REFERENCES Kullanýcý(Kullanýcý_id),
	Oyun_id int FOREIGN KEY REFERENCES Oyun(Oyun_id),
)
GO

CREATE TABLE Teklif(
	Teklif_id int NOT NULL PRIMARY KEY,
	Miktar int NOT NULL,
	Envanter_id int FOREIGN KEY REFERENCES Envanter_kaydý(Envanter_id),
	Kullanýcý_id int FOREIGN KEY REFERENCES Kullanýcý(Kullanýcý_id),
)
GO

CREATE TABLE Yorum(
	Yorum_id int NOT NULL,
	Beðeni int NULL,
	Pozitif_Negatif bit NULL,
	Yorum_Tarihi datetime NULL,
	Kullanýcý_id int  FOREIGN KEY REFERENCES Kullanýcý(Kullanýcý_id),
	Oyun_id int FOREIGN KEY REFERENCES Oyun(Oyun_id),
)
GO

