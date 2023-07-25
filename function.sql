/*Olu�turulacak nesnenin veritaban�nda var olup olmad���n�  kontrol eden varsa silen kod b�l�m�.*/
IF OBJECT_ID('dbo.fncGenelBegeni') IS NOT NULL BEGIN DROP FUNCTION fncGenelBegeni END 
GO 

CREATE FUNCTION fncGenelBegeni(@OyunID AS INT) RETURNS INT AS
BEGIN
	DECLARE @be�eni int
	DECLARE @Oyunid int
	DECLARE @genelbegeni INT 
	DECLARE @pozitifnegatif INT
	/*ID'si girilen oyunlar�n genel be�enilerini hesaplarken tek tek sat�rlara ula�mak i�in burada cursor kullan�ld�.*/
	DECLARE Yorumlar CURSOR FOR SELECT Be�eni, Pozitif_Negatif, Oyun_id FROM Yorum where Oyun_id = @OyunID
	Set @genelbegeni = 0
	OPEN Yorumlar
	FETCH NEXT FROM Yorumlar INTO @be�eni,@pozitifnegatif,@Oyunid
	WHILE @@FETCH_STATUS = 0
		BEGIN
			IF @pozitifnegatif = 1
				BEGIN
					Set @genelbegeni = @genelbegeni + @be�eni
				END
			ELSE 
				BEGIN
					
					Set @genelbegeni = @genelbegeni + @be�eni * -1
				END
			FETCH NEXT FROM Yorumlar INTO @be�eni,@pozitifnegatif,@Oyunid
		END
	CLOSE Yorumlar
	DEALLOCATE Yorumlar
/*Genel be�eni puan�na g�re bir y�zdelik puan atamas� yap�ld�.*/
	IF @genelbegeni >= 500
		BEGIN SET @genelbegeni= 100 END
	ELSE IF @genelbegeni >= 250
		BEGIN SET @genelbegeni= 90 END
	ELSE IF @genelbegeni >= 100
		BEGIN SET @genelbegeni= 85 END
	ELSE IF @genelbegeni >= 80
		BEGIN SET @genelbegeni= 80 END
	ELSE IF @genelbegeni >= 60
		BEGIN SET @genelbegeni= 75 END
	ELSE IF @genelbegeni >= 50
		BEGIN SET @genelbegeni= 70 END
	ELSE IF @genelbegeni >= 30
		BEGIN SET @genelbegeni= 70 END
	ELSE IF @genelbegeni >= 10
		BEGIN SET @genelbegeni= 60 END
	ELSE IF @genelbegeni > 0
		BEGIN SET @genelbegeni= 55 END
	ELSE IF @genelbegeni = 0
		BEGIN SET @genelbegeni= 50 END
	ELSE IF @genelbegeni >= -20
		BEGIN SET @genelbegeni= 48 END
	ELSE IF @genelbegeni >= -40
		BEGIN SET @genelbegeni= 45 END
	ELSE IF @genelbegeni >= -60
		BEGIN SET @genelbegeni= 43 END
	ELSE IF @genelbegeni >= -80
		BEGIN SET @genelbegeni= 40 END
	ELSE IF @genelbegeni >= -100
		BEGIN SET @genelbegeni= 35 END
	ELSE IF @genelbegeni >= -150
		BEGIN SET @genelbegeni= 30 END
	ELSE IF @genelbegeni >= -250
		BEGIN SET @genelbegeni= 20 END
	ELSE IF @genelbegeni >= -500
		BEGIN SET @genelbegeni= 15 END
	ELSE
		BEGIN SET @genelbegeni = 10 END

	RETURN @genelbegeni
END
GO

/* ID'si girilen oyunun genel be�eni puan�n� veren fonksiyon SELECT sorgusu i�erisinde kullan�lm��t�r.*/

SELECT Oyun_ismi,
dbo.fncGenelBegeni(4) AS "Genel Be�eni Puan�",
CASE WHEN dbo.fncGenelBegeni(4) < 50 THEN 'Be�enilmedi'
	 ELSE 'Be�enildi' END AS "Be�enilme Durumu"
FROM Oyun WHERE Oyun_id=4
