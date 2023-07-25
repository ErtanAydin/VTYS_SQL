/*Olu�turulacak nesnenin veritaban�nda var olup olmad���n�  kontrol eden varsa silen kod b�l�m�.*/
IF OBJECT_ID ('dbo.insertSP') IS NOT NULL
	BEGIN
		DROP PROCEDURE insertSP
	END
GO
--//Oyun listesine yeni oyun ekleme\\--
/*Transaction kullanarak oyun tablosuna yeni oyunlar eklenmesini sa�layan procedure olu�turuldu.*/
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
		SAVE TRANSACTION insertSP_Kay�t

	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @hata INT
		INSERT INTO Oyun(Oyun_id,��k��_Tarihi,Oyun_ismi,Oyun_fiyat�,Geli�tirici_id,Yay�nc�_id) VALUES (@OID,@tarih,@OAD,@OFYT,@GID,@YID)
		COMMIT
	END TRY

	BEGIN CATCH
		IF @TranCounter = 0 OR XACT_STATE() = -1
		BEGIN 
			ROLLBACK TRANSACTION
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION insertSP_Kay�t
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

/*Olu�turulacak nesnenin veritaban�nda var olup olmad���n�  kontrol eden varsa silen kod b�l�m�.*/
IF OBJECT_ID('dbo.updateSP') IS NOT NULL
	BEGIN 
		DROP PROCEDURE updateSP
	END
GO
--//Ba�ar�m�n Ad�n� G�ncelleyen Procedure\\--
CREATE PROCEDURE updateSP(@ba��d char(10), @ba�is char(50))
AS
BEGIN
	update Ba�ar�m
	SET Ba�ar�m_isim = @ba�is
	WHERE Ba�ar�m_id=@ba��d
END

EXEC updateSP '5','5 b�c�k ez'
SELECT * FROM Ba�ar�m


---------------------------------------------------------------------------------

/*Olu�turulacak nesnenin veritaban�nda var olup olmad���n�  kontrol eden varsa silen kod b�l�m�.*/
IF OBJECT_ID('dbo.selectSP') IS NOT NULL
	BEGIN
		DROP PROCEDURE selectSP
	END

GO
--//Girilen oyuna yap�lan pozitif yorumlar ve yorumlar� yapan ki�ilerin email adresleri\\--
CREATE PROCEDURE selectSP
(
	@oyun CHAR(30)
)
AS
BEGIN
	SELECT DISTINCT PYorum.Be�eni,PYorum.Yorum_Tarihi,K.Email 
	FROM (Select * From Yorum Where Pozitif_Negatif=1) PYorum 
		   INNER JOIN Kullan�c� K ON PYorum.Kullan�c�_id=K.Kullan�c�_id 
		   INNER JOIN Oyun O ON PYorum.Oyun_id=O.Oyun_id
	WHERE O.Oyun_ismi = @oyun
END

EXEC selectSP 'COD MW2'

-----------------------------------------------------------------------------------

/*Olu�turulacak nesnenin veritaban�nda var olup olmad���n�  kontrol eden varsa silen kod b�l�m�.*/
IF OBJECT_ID('dbo.deleteSP') IS NOT NULL
	BEGIN
		DROP PROCEDURE deleteSP
	END
GO
--//Be�enisi girilen de�erden d���k olan olumsuz yorumlar� silme\\--
CREATE PROCEDURE deleteSP
(
	@sayi VARCHAR(10)
)
AS
BEGIN
	DELETE FROM Yorum 
		WHERE Yorum.Pozitif_Negatif=0 And Yorum.Be�eni <= @sayi
END

Exec deleteSP '30'
-----------------------------------------------------------------------------------


/*Olu�turulacak nesnenin veritaban�nda var olup olmad���n�  kontrol eden varsa silen kod b�l�m�.*/
IF OBJECT_ID('dbo.cursorSP') IS NOT NULL
	BEGIN
		DROP PROCEDURE cursorSP
	END
GO
--Cursor kullanarak girilen kullan�c�n�n istek listesindeki oyunlar�n fonksiyon yard�m�yla genel be�eni y�zdelerinin hesaplanmas�--
CREATE PROCEDURE cursorSP
(
	@Kullan�c�ID int
)
AS
BEGIN
	declare @istekListesiOyunlar� TABLE (Kullan�c�ID INT, OyunID INT, Oyun_ismi NVARCHAR(100), Be�eniY�zdesi NVARCHAR(5), Be�enilmeDurumu NVARCHAR(11))
	declare @pozitifnegatif int
	declare @OyunID int
	declare @be�eni int
	declare @Kullan�c�id int
	declare @Oyunid int
	declare @Oyunismi varchar(100)
	DECLARE istekListesi CURSOR FOR SELECT K.Kullan�c�_id,O.Oyun_id, Oyun_ismi FROM Kullan�c� k INNER JOIN �stek_Listesi i ON k.Kullan�c�_id = i.Kullan�c�_id INNER JOIN Bulundurur b ON i.istekliste_id = b.istek_id
			INNER JOIN Oyun o ON b.Oyun_id = o.Oyun_id WHERE @Kullan�c�ID = k.Kullan�c�_id
	OPEN istekListesi
	FETCH NEXT FROM istekListesi INTO @Kullan�c�id,@Oyunid,@Oyunismi
	WHILE @@FETCH_STATUS = 0
		BEGIN
			INSERT @istekListesiOyunlar� SELECT @Kullan�c�id,@Oyunid,@Oyunismi,dbo.fncGenelBegeni(@Oyunid) AS "Genel Be�eni Puan�",
					CASE WHEN dbo.fncGenelBegeni(@Oyunid) < 50 THEN 'Be�enilmedi'
							ELSE 'Be�enildi' END AS "Be�enilme Durumu"
					FROM Oyun WHERE Oyun_id=@Oyunid
			
				
			FETCH NEXT FROM istekListesi INTO @Kullan�c�id,@Oyunid,@Oyunismi
		END
	SELECT * FROM @istekListesiOyunlar�
	CLOSE istekListesi
	DEALLOCATE istekListesi
END
GO


Exec cursorSP 3

