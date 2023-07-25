/*Oluþturulacak nesnenin veritabanýnda var olup olmadýðýný  kontrol eden varsa silen kod bölümü.*/
IF OBJECT_ID('dbo.SilinenYorum') IS NOT NULL
	BEGIN
		DROP TABLE SilinenYorum
	END
GO

--//Silinen yorumlarý tabloya yazan trigger\\--
CREATE TABLE SilinenYorum
(
Yorum_id int NOT NULL,
	Beðeni int NULL,
	Pozitif_Negatif bit NULL,
	Yorum_Tarihi datetime NULL,
	Kullanýcý_id int ,
	Oyun_id int,
)
IF OBJECT_ID('dbo.Silme') IS NOT NULL
	BEGIN
		DROP trigger Silme
	END
GO
CREATE TRIGGER Silme
ON Yorum AFTER DELETE AS
	INSERT INTO SilinenYorum select* from deleted

EXEC deleteSP '30'
SELECT * FROM SilinenYorum