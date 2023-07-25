USE AdventureWorks2019

--8.Soru

Create Function Test1 (@AY NVARCHAR(10), @YIL INT)
Returns VARCHAR(15)
BEGIN

	Declare @Sonuc VARCHAR(15)
	Set @Sonuc = (
	Select AccountNumber
	From Sales.SalesOrderHeader
	Where @AY = DATENAME( MONTH, OrderDate) AND @YIL = DATENAME( YEAR, ORDERDATE)
	)
	RETURN @Sonuc
END


GO

SeLect dbo.Test1(08, 2020)

--7. Soru
Create Function AsalSayiTest(@Sayi INT)
Returns VARCHAR(30)
BEGIN

	Declare @Sayac INT = 0
	Declare @Numara INT = 1
	Declare @Sonuc VARCHAR(30)

	WHILE (@Sayi >= @Numara) 
	BEGIN
		IF (@Sayi % @Numara = 0)
		BEGIN
			SET @Sayac = @Sayac + 1

		END
		Set @Numara = @Numara + 1
	END

	IF (@Sayac > 2)
	BEGIN 
		SET @Sonuc ='ASAL BIR SAYI DEGILDIR'
	END 
	ELSE
	BEGIN
		SET @Sonuc ='ASAL BIR SAYIDIR'
	END
	
	RETURN @Sonuc

END

GO

Select dbo.AsalSayiTest(30) As Sonuc



