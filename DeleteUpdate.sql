-- UPDATE
-- tabela Klient
select * from Klient
--1) Zmiana nazwiska, masta i numeru telefonu u Klienta z ID o numerze 5
UPDATE Klient
SET Nazwisko='Drzewo', Miasto='Mierzêcice', Nr_telefonu=983062198
WHERE ID_Klient=5
--2) Zamian miasta u Klientów, kórych ID jest wiêksze ni¿ 10 a imie zaczyna siê od K lub A 
UPDATE Klient
SET Miasto='New York'
WHERE ID_Klient>10 AND (Imie LIKE 'K%' OR Imie LIKE 'A%')
--3) Zamian numeru telefonu u Klientów, których plec jest równa 0, czyli u kobiet
UPDATE Klient
SET Nr_telefonu=Nr_telefonu+10
WHERE Plec=0 

-- tabela Wymiary 
select * from Wymiary
-- 1) zmiana wzrostu w wymiarch, gdzie ID klienta jest parzyste
UPDATE Wymiary
SET Wzrost=Wzrost+2
FROM Wymiary AS W
JOIN Klient AS K
ON W.ID_wymiary=K.ID_wymiary
WHERE K.ID_Klient%2=0
-- 2) zmiana obwodu talii tam gdzie d³ugoœæ nogi jest wiêksza ni¿ 85
UPDATE Wymiary
SET Obwod_Talia=Obwod_Talia*1.2
WHERE Dlugosc_Noga<85
-- 3) zmiana  obwodu nadgarstka tylko u kobiet
UPDATE Wymiary
SET Obwod_Nadgarstek=Obwod_Nadgarstek-1
FROM Wymiary AS W 
JOIN Klient AS K
ON W.ID_wymiary=K.ID_wymiary
WHERE Plec=0

--tabela ZamowieniaAsortyment
SELECT * FROM ZamowieniaAsortyment
--1) zamiana ceny zamówienia tam gdzie czas realizowania zamówienia na asortyment by³ d³u¿szy ni¿ 15 dni
UPDATE ZamowieniaAsortyment
SET Cena=Cena-50
WHERE DATEDIFF(DD, Data_odebrania_zamowienia, Data_zlozenia_zamowienia)>15
--2) zamiana ID oddzia³u tam gdzie cena zamówienia by³a mniejsza ni¿ 300
UPDATE ZamowieniaAsortyment
SET ID_oddzial=8
WHERE Cena<300 
--3) zamiana szcegó³ów dla zamówieñ, któryh ID jest wiêksze ni¿ 25 i cena mniejsza ni¿ 700
UPDATE ZamowieniaAsortyment
SET Szczegoly='BRAK'
WHERE ID_zamowienie>25 AND Cena<700

--tabela Pracownicy 
SELECT * FROM Pracownicy
--1) zmiana numeru telefonu u pracowników, których oddzia³ mnia³ najwiêksze zarobki
UPDATE Pracownicy
SET Nr_telefonu=Nr_telefonu+15
FROM (SELECT TOP 1 ID_Oddzial AS ID FROM Zarobki AS Z JOIN Pracownicy AS P ON Z.ID_pracownik=P.ID_pracownik GROUP BY P.ID_oddzial ORDER BY SUM(Z.Suma) DESC) Emp
WHERE Pracownicy.ID_oddzial=Emp.ID
--2) zmiana nazwiska u kierowników i kierowniczek zmianowych
UPDATE Pracownicy
SET Stanowisko='KZ'
WHERE Stanowisko = 'Kierowniczka zmianowa' OR  Stanowisko = 'Kierownik zmianowy'    
--3) zmiana nazwy stanowiska u krawcowej, która najwiêcej zarobi³a
UPDATE Pracownicy
SET Stanowisko='KZ+'
FROM (SELECT TOP 1 Z.ID_pracownik AS ID FROM Zarobki AS Z JOIN Pracownicy AS P ON Z.ID_pracownik=P.ID_pracownik WHERE Stanowisko = 'Krawcowa' OR Stanowisko = 'Krawiec' GROUP BY Z.ID_pracownik ORDER BY SUM(Suma) DESC ) Zab
WHERE Pracownicy.ID_pracownik=Zab.ID

--tabela Zarobki
SELECT * FROM Zarobki
--1) zmiana sumy dla zarobków, których daty wykonania by³y mniejsze ni¿ 5 dni
UPDATE Zarobki
SET Suma=Suma+100
FROM (SELECT ID_zamowienie AS ID FROM ZamowieniaKlient WHERE DATEDIFF(DD, Data_zlozenia_zamowienia, Data_wyslania_zamowienia)<8) Zab
WHERE Zarobki.ID_zamowienie=Zab.ID
--2) zmiana daty dla zamówieñ z marca w cenie 100-500 z³
UPDATE Zarobki
SET Data='2020-04-28 12:20:01'
WHERE MONTH(Data)=03 AND Suma>100 AND Suma<500
--3) zmiana sumy dla zamówieñ z kwietnia 
UPDATE Zarobki
SET Suma=Suma*0.9
WHERE MONTH(Data)=04

--tabela ZamowieniaKlient 
SELECT * FROM ZamowieniaKlient
--1)zmiana ceny dla zmówieñ, które maj¹ ID parzyste i cenê mniejsz¹ ni¿ 100
UPDATE ZamowieniaKlient
SET Cena=Cena-10
WHERE ID_zamowienie%2=0 AND Cena<100
--2) zmiana szczegó³ów dla zamówien, których ID klienta jest parzyste oraz szczegó³y zaczynaj¹ siê na s
UPDATE ZamowieniaKlient
SET Szczegoly='BRAK'
WHERE Szczegoly LIKE 's%' AND ID_Klient%2=0
--3) zmiana daty wys³ania zamówienia dla zamówienia, którego ID klienta jest parzyste
UPDATE ZamowieniaKlient
SET Data_wyslania_zamowienia='1990-01-01 01:01:01'
WHERE ID_Klient%2=0


--DELETE
--tabela ZamowieniaAsortyment
SELECT * FROM ZamowieniaAsortyment
--1) usuniêcie rekordów, którcyh realizacja by³a d³u¿sza ni¿ 15 dni
DELETE FROM ZamowieniaAsortyment WHERE DATEDIFF(DD, Data_zlozenia_zamowienia, Data_odebrania_zamowienia)>15
--2) usuniêcie rekordu, którego cena jest najmniejsza
DELETE FROM ZamowieniaAsortyment WHERE ID_zamowienie=(SELECT TOP 1 ID_zamowienie FROM ZamowieniaAsortyment ORDER BY Cena ASC )
--3) usuniêcie rekordów, które zosat³y z³o¿one w 4 dniu miesi¹ca i maj¹ parzyste ID
DELETE FROM ZamowieniaAsortyment WHERE DAY(Data_zlozenia_zamowienia)=04 AND ID_zamowienie%2=0
--DELETE FROM Pracownicy
--DELETE FROM Zarobki --
--DELETE FROM Oddzialy
--DELETE FROM Klient
--DELETE FROM ZamowieniaAsortyment
--DELETE FROM ZamowieniaKlient --
--DELETE FROM Wymiary


--CASCADE DELETE
--1) usuniêcie rekordu, dla którego ID wymiarów by³o równe 10
SELECT * FROM Wymiary
SELECT * FROM Klient
SELECT * FROM ZamowieniaKlient
SELECT * FROM Zarobki
DELETE FROM Wymiary WHERE ID_wymiary=10
--2) usuniêcie krawcowej, która najmniej zarobi³a
SELECT * FROM Zarobki
SELECT * FROM Pracownicy
DELETE FROM Pracownicy WHERE Pracownicy.ID_pracownik=(SELECT TOP 1 P.ID_pracownik FROM Pracownicy AS P JOIN Zarobki AS Z ON P.ID_pracownik=Z.ID_pracownik WHERE Stanowisko = 'Krawcowa' OR Stanowisko = 'Krawiec' GROUP BY P.ID_pracownik ORDER BY SUM(Z.Suma) ASC)
--3) usuniêcie danych wymiarów, gdzie wzrost jest wiêkszy ni¿ 190
SELECT * FROM Wymiary
SELECT * FROM Klient
SELECT * FROM ZamowieniaKlient
SELECT * FROM Zarobki
DELETE FROM Wymiary WHERE Wzrost>=190
--4) usuniêcie pracownika,który przyj¹³ najwiêksze zamówienie w 2019
SELECT * FROM Pracownicy
SELECT * FROM Zarobki
DELETE FROM Pracownicy WHERE Pracownicy.ID_pracownik=(SELECT TOP 1 ID_pracownik FROM Zarobki WHERE YEAR(Data)=2019 ORDER BY Suma DESC )
--5) usun¹æ zamówienia, których realizacja  by³a na minusie
SELECT * FROM ZamowieniaKlient
SELECT * FROM Zarobki
DELETE FROM ZamowieniaKlient WHERE ID_zamowienie IN (SELECT ID_zamowienie FROM ZamowieniaKlient WHERE DATEDIFF(DD, Data_zlozenia_zamowienia, Data_wyslania_zamowienia)<0)
--CASCADE UPDATE
--1) aktualizowanie id wymiarów z 2 na 31
SELECT * FROM Wymiary
SELECT * FROM Klient
UPDATE Wymiary SET ID_wymiary=31 WHERE ID_wymiary=2
--2) zamiana ID pracownika, gdzie suma >=150
SELECT * FROM Zarobki
SELECT * FROM Pracownicy
UPDATE Pracownicy SET ID_pracownik=ID_pracownik+100 WHERE ID_pracownik IN (SELECT ID_pracownik FROM Zarobki WHERE Suma>=150)
--3) zmiana ID oddzia³u z 8 na 10
SELECT * FROM Pracownicy
SELECT * FROM Oddzialy
SELECT * FROM ZamowieniaAsortyment
UPDATE Oddzialy SET ID_oddzial=10 WHERE ID_oddzial=8
--4) zmiana ID klienta, gdy jesgo nazwisko zaczyna siê od k lub d
SELECT * FROM Klient
SELECT * FROM ZamowieniaKlient
UPDATE Klient SET ID_Klient=ID_Klient+200 WHERE Nazwisko LIKE 'D%' OR Nazwisko LIKE 'K%'
--5) zmiana ID zamowienia tam gdzie cena jest najni¿sza
SELECT * FROM ZamowieniaKlient
SELECT * FROM Zarobki
UPDATE ZamowieniaKlient SET ID_zamowienie=ID_zamowienie+100 WHERE Cena=(SELECT TOP 1 Cena FROM ZamowieniaKlient ORDER BY Cena DESC)

