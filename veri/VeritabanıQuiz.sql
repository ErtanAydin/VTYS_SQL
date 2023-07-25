
--1)

Select * from employees where SALARY > (select SALARY from employees where EMPLOYEE_ID=150)

--2)

Select * from employees
INNER JOIN departments ON employees.DEPARTMENT_ID = departments.DEPARTMENT_ID
INNER JOIN locations ON departments.LOCATION_ID = locations.LOCATION_ID
INNER JOIN countries ON locations.COUNTRY_ID = countries.COUNTRY_ID
where COUNTRY_NAME = ' Turkey '

--3)

Select * from employees
where JOB_ID IS NULL

--4)

Select AVG(SALARY) from employees
INNER JOIN departments ON employees.DEPARTMENT_ID = departments.DEPARTMENT_ID
where DEPARTMENT_NAME ='IT'

--5)

Select Count(*), * 
from employees
INNER JOIN (Select EMPLOYEE_ID, COUNT(*) AS C
FROM job_history
GROUP BY EMPLOYEE_ID) ON  employees.EMPLOYEE_ID = job_history.EMPLOYEE_ID
WHERE C > 3



Select Kullanıcı_ıd, Sum(Alış_fiyatı), Sum(Satış_fiyatı),
	(Select Count(Alış_Tarihi) from Envanter_kaydı) AS Alan,
	(Select Count(Satış_Tarihi) from Envanter_kaydı) AS Satan
	From Kullanıcı
INNER JOIN Envanter_kaydı ON Kullanıcı.Kullanıcı_ıd = Envanter_kaydı.Kullanıcı_ıd
WHERE Alış_Tarihi between '01/01/2019' and '12/31/2019' AND Satış_Tarihi between '01/01/2019' and '12/31/2019'
Group BY Kullanıcı_ıd
HAVING Alan >= 5 OR Satan >=5














Select top 3 Kullanıcı_ıd, isim from Kategori
INNER JOIN Aittır ON Kategori.Kategori_ıd = Aittır.Kategori_ıd
INNER JOIN Oyun ON Aittır.Oyun_id = Oyun.Oyun_id
INNER JOIN Kopya ON Oyun.Oyun_id = Kopya.Oyun_id
INNER JOIN Kullanıcı ON Kopya.Kullanıcı_ıd = Kullanıcı.Kullanıcı_ıd
WHERE isim = 'Futbol' and Oyun_Sayısı = 0
GROUP BY Kullanıcı_ıd
ORDER BY Oyun_Sayısı DESC



