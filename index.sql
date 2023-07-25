/*Olu�turulacak nesnenin veritaban�nda var olup olmad���n�  kontrol eden varsa silen kod b�l�m�.*/
BEGIN DROP INDEX IF EXISTS steamIndex ON Yay�nc� END 

GO 
/*Yay�nc� tablosunda aramay� h�zland�rmak i�in nonclustered index olu�turuldu*/
CREATE NONCLUSTERED INDEX steamIndex ON Yay�nc� (Yay�nc�_id, Yay�nc�_ciro, Yay�nc�_isim)
WITH (PAD_INDEX = ON, FILLFACTOR = 90,DROP_EXISTING = OFF)

DECLARE @x INT=17, @y INT
DECLARE @yayinci_ciro INT=0
DECLARE @yayinci_isim VARCHAR(30)
/*Yay�nc� tablosu, nonclustered index i test etmek amac�yla rastgele de�erlerle dolduruldu.*/
WHILE @x<10000
	BEGIN
		IF @x < 5000
			BEGIN
				SET @yayinci_ciro = 0
				SET @yayinci_isim = 'denemeYayinci'
			END
		ELSE
			BEGIN
				SET @y=(CONVERT(INT,ROUND(RAND()*10,0)) % 10)+1
				SELECT @yayinci_ciro=Yay�nc�_ciro FROM Yay�nc� WHERE Yay�nc�_id=@y
				SELECT @yayinci_isim=Yay�nc�_isim FROM Yay�nc� WHERE Yay�nc�_id=@y
			END
		INSERT INTO Yay�nc� VALUES (@x,@yayinci_ciro,@yayinci_isim)
		SET @x+=1
	END
GO

SELECT * FROM Yay�nc� WHERE Yay�nc�_isim = 'EA'