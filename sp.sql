/*Oluþturulacak nesnenin veritabanýnda var olup olmadýðýný  kontrol eden varsa silen kod bölümü.*/
IF OBJECT_ID ('dbo.insertSP') IS NOT NULL
	BEGIN
		DROP PROCEDURE insertSP
	END
GO
--//Oyun listesine yeni oyun ekleme\\--
/*Transaction kullanarak oyun tablosuna yeni oyunlar eklenmesini saðlayan procedure oluþturuldu.*/
CREATE PROCEDURE insertSP
( 
	@OID CHAR (10), 
	@tarih DATE,
	@OAD CHAR(20),
	@OFYT INT,
	@GID CHAR(10),
	@YID CHAR(10)
)
AS
	DECLARE @TranCounter INT = @@TRANCOUNT
	IF @TranCounter > 0
		SAVE TRANSACTION insertSP_Kayýt

	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @hata INT
		INSERT INTO Oyun(Oyun_id,Çýkýþ_Tarihi,Oyun_ismi,Oyun_fiyatý,Geliþtirici_id,Yayýncý_id) VALUES (@OID,@tarih,@OAD,@OFYT,@GID,@YID)
		COMMIT
	END TRY

	BEGIN CATCH
		IF @TranCounter = 0 OR XACT_STATE() = -1
		BEGIN 
			ROLLBACK TRANSACTION
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION insertSP_Kayýt
			COMMIT
		END
		SELECT * FROM sys.messages WHERE language_id=1055 AND message_id=ERROR_NUMBER()
	END CATCH
GO
/*Procedure test edildi.*/
EXEC insertSP 12,'2018-07-15','Among Us', 100,14,13
EXEC insertSP 13,'2013-09-17','GTA V', 80,15,14
EXEC insertSP 14,'2018-10-26','Red Dead Redemption 2', 290,15,14
EXEC insertSP 15,'2012-08-21','Counter-Strike: Global Offensive', 0,16,15
EXEC insertSP 16,'2009-10-27','League of Legends', 0,17,16
EXEC insertSP 17,'2020-10-05','FIFA 21', 300,9,4
EXEC insertSP 18,'2019-07-30','PES 2020', 150,7,8
EXEC insertSP 19,'2013-10-11','The Wolf Among Us', 40,8,6
GO

SELECT * FROM Oyun
-----------------------------------------------------------------------------------

/*Oluþturulacak nesnenin veritabanýnda var olup olmadýðýný  kontrol eden varsa silen kod bölümü.*/
IF OBJECT_ID('dbo.updateSP') IS NOT NULL
	BEGIN 
		DROP PROCEDURE updateSP
	END
GO
--//Baþarýmýn Adýný Güncelleyen Procedure\\--
CREATE PROCEDURE updateSP(@baþýd char(10), @baþis char(50))
AS
BEGIN
	update Baþarým
	SET Baþarým_isim = @baþis
	WHERE Baþarým_id=@baþýd
END

EXEC updateSP '5','5 böcük ez'
SELECT * FROM Baþarým


---------------------------------------------------------------------------------

/*Oluþturulacak nesnenin veritabanýnda var olup olmadýðýný  kontrol eden varsa silen kod bölümü.*/
IF OBJECT_ID('dbo.selectSP') IS NOT NULL
	BEGIN
		DROP PROCEDURE selectSP
	END

GO
--//Girilen oyuna yapýlan pozitif yorumlar ve yorumlarý yapan kiþilerin email adresleri\\--
CREATE PROCEDURE selectSP
(
	@oyun CHAR(30)
)
AS
BEGIN
	SELECT DISTINCT PYorum.Beðeni,PYorum.Yorum_Tarihi,K.Email 
	FROM (Select * From Yorum Where Pozitif_Negatif=1) PYorum 
		   INNER JOIN Kullanýcý K ON PYorum.Kullanýcý_id=K.Kullanýcý_id 
		   INNER JOIN Oyun O ON PYorum.Oyun_id=O.Oyun_id
	WHERE O.Oyun_ismi = @oyun
END

EXEC selectSP 'COD MW2'

-----------------------------------------------------------------------------------

/*Oluþturulacak nesnenin veritabanýnda var olup olmadýðýný  kontrol eden varsa silen kod bölümü.*/
IF OBJECT_ID('dbo.deleteSP') IS NOT NULL
	BEGIN
		DROP PROCEDURE deleteSP
	END
GO
--//Beðenisi girilen deðerden düþük olan olumsuz yorumlarý silme\\--
CREATE PROCEDURE deleteSP
(
	@sayi VARCHAR(10)
)
AS
BEGIN
	DELETE FROM Yorum 
		WHERE Yorum.Pozitif_Negatif=0 And Yorum.Beðeni <= @sayi
END

Exec deleteSP '30'
-----------------------------------------------------------------------------------


/*Oluþturulacak nesnenin veritabanýnda var olup olmadýðýný  kontrol eden varsa silen kod bölümü.*/
IF OBJECT_ID('dbo.cursorSP') IS NOT NULL
	BEGIN
		DROP PROCEDURE cursorSP
	END
GO
--Cursor kullanarak girilen kullanýcýnýn istek listesindeki oyunlarýn fonksiyon yardýmýyla genel beðeni yüzdelerinin hesaplanmasý--
CREATE PROCEDURE cursorSP
(
	@KullanýcýID int
)
AS
BEGIN
	declare @istekListesiOyunlarý TABLE (KullanýcýID INT, OyunID INT, Oyun_ismi NVARCHAR(100), BeðeniYüzdesi NVARCHAR(5), BeðenilmeDurumu NVARCHAR(11))
	declare @pozitifnegatif int
	declare @OyunID int
	declare @beðeni int
	declare @Kullanýcýid int
	declare @Oyunid int
	declare @Oyunismi varchar(100)
	DECLARE istekListesi CURSOR FOR SELECT K.Kullanýcý_id,O.Oyun_id, Oyun_ismi FROM Kullanýcý k INNER JOIN Ýstek_Listesi i ON k.Kullanýcý_id = i.Kullanýcý_id INNER JOIN Bulundurur b ON i.istekliste_id = b.istek_id
			INNER JOIN Oyun o ON b.Oyun_id = o.Oyun_id WHERE @KullanýcýID = k.Kullanýcý_id
	OPEN istekListesi
	FETCH NEXT FROM istekListesi INTO @Kullanýcýid,@Oyunid,@Oyunismi
	WHILE @@FETCH_STATUS = 0
		BEGIN
			INSERT @istekListesiOyunlarý SELECT @Kullanýcýid,@Oyunid,@Oyunismi,dbo.fncGenelBegeni(@Oyunid) AS "Genel Beðeni Puaný",
					CASE WHEN dbo.fncGenelBegeni(@Oyunid) < 50 THEN 'Beðenilmedi'
							ELSE 'Beðenildi' END AS "Beðenilme Durumu"
					FROM Oyun WHERE Oyun_id=@Oyunid
			
				
			FETCH NEXT FROM istekListesi INTO @Kullanýcýid,@Oyunid,@Oyunismi
		END
	SELECT * FROM @istekListesiOyunlarý
	CLOSE istekListesi
	DEALLOCATE istekListesi
END
GO


Exec cursorSP 3

