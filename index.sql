/*Oluþturulacak nesnenin veritabanýnda var olup olmadýðýný  kontrol eden varsa silen kod bölümü.*/
BEGIN DROP INDEX IF EXISTS steamIndex ON Yayýncý END 

GO 
/*Yayýncý tablosunda aramayý hýzlandýrmak için nonclustered index oluþturuldu*/
CREATE NONCLUSTERED INDEX steamIndex ON Yayýncý (Yayýncý_id, Yayýncý_ciro, Yayýncý_isim)
WITH (PAD_INDEX = ON, FILLFACTOR = 90,DROP_EXISTING = OFF)

DECLARE @x INT=17, @y INT
DECLARE @yayinci_ciro INT=0
DECLARE @yayinci_isim VARCHAR(30)
/*Yayýncý tablosu, nonclustered index i test etmek amacýyla rastgele deðerlerle dolduruldu.*/
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
				SELECT @yayinci_ciro=Yayýncý_ciro FROM Yayýncý WHERE Yayýncý_id=@y
				SELECT @yayinci_isim=Yayýncý_isim FROM Yayýncý WHERE Yayýncý_id=@y
			END
		INSERT INTO Yayýncý VALUES (@x,@yayinci_ciro,@yayinci_isim)
		SET @x+=1
	END
GO

SELECT * FROM Yayýncý WHERE Yayýncý_isim = 'EA'