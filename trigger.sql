/*Olu�turulacak nesnenin veritaban�nda var olup olmad���n�  kontrol eden varsa silen kod b�l�m�.*/
IF OBJECT_ID('dbo.SilinenYorum') IS NOT NULL
	BEGIN
		DROP TABLE SilinenYorum
	END
GO

--//Silinen yorumlar� tabloya yazan trigger\\--
CREATE TABLE SilinenYorum
(
Yorum_id int NOT NULL,
	Be�eni int NULL,
	Pozitif_Negatif bit NULL,
	Yorum_Tarihi datetime NULL,
	Kullan�c�_id int ,
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