-- UPDATE
-- tabela Klient
select * from Klient
--1) Zmiana nazwiska, masta i numeru telefonu u Klienta z ID o numerze 5
UPDATE Klient
SET Nazwisko='Drzewo', Miasto='Mierz�cice', Nr_telefonu=983062198
WHERE ID_Klient=5
--2) Zamian miasta u Klient�w, k�rych ID jest wi�ksze ni� 10 a imie zaczyna si� od K lub A 
UPDATE Klient
SET Miasto='New York'
WHERE ID_Klient>10 AND (Imie LIKE 'K%' OR Imie LIKE 'A%')
--3) Zamian numeru telefonu u Klient�w, kt�rych plec jest r�wna 0, czyli u kobiet
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
-- 2) zmiana obwodu talii tam gdzie d�ugo�� nogi jest wi�ksza ni� 85
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
--1) zamiana ceny zam�wienia tam gdzie czas realizowania zam�wienia na asortyment by� d�u�szy ni� 15 dni
UPDATE ZamowieniaAsortyment
SET Cena=Cena-50
WHERE DATEDIFF(DD, Data_odebrania_zamowienia, Data_zlozenia_zamowienia)>15
--2) zamiana ID oddzia�u tam gdzie cena zam�wienia by�a mniejsza ni� 300
UPDATE ZamowieniaAsortyment
SET ID_oddzial=8
WHERE Cena<300 
--3) zamiana szceg��w dla zam�wie�, kt�ryh ID jest wi�ksze ni� 25 i cena mniejsza ni� 700
UPDATE ZamowieniaAsortyment
SET Szczegoly='BRAK'
WHERE ID_zamowienie>25 AND Cena<700

--tabela Pracownicy 
SELECT * FROM Pracownicy
--1) zmiana numeru telefonu u pracownik�w, kt�rych oddzia� mnia� najwi�ksze zarobki
UPDATE Pracownicy
SET Nr_telefonu=Nr_telefonu+15
FROM (SELECT TOP 1 ID_Oddzial AS ID FROM Zarobki AS Z JOIN Pracownicy AS P ON Z.ID_pracownik=P.ID_pracownik GROUP BY P.ID_oddzial ORDER BY SUM(Z.Suma) DESC) Emp
WHERE Pracownicy.ID_oddzial=Emp.ID
--2) zmiana nazwiska u kierownik�w i kierowniczek zmianowych
UPDATE Pracownicy
SET Stanowisko='KZ'
WHERE Stanowisko = 'Kierowniczka zmianowa' OR  Stanowisko = 'Kierownik zmianowy'    
--3) zmiana nazwy stanowiska u krawcowej, kt�ra najwi�cej zarobi�a
UPDATE Pracownicy
SET Stanowisko='KZ+'
FROM (SELECT TOP 1 Z.ID_pracownik AS ID FROM Zarobki AS Z JOIN Pracownicy AS P ON Z.ID_pracownik=P.ID_pracownik WHERE Stanowisko = 'Krawcowa' OR Stanowisko = 'Krawiec' GROUP BY Z.ID_pracownik ORDER BY SUM(Suma) DESC ) Zab
WHERE Pracownicy.ID_pracownik=Zab.ID

--tabela Zarobki
SELECT * FROM Zarobki
--1) zmiana sumy dla zarobk�w, kt�rych daty wykonania by�y mniejsze ni� 5 dni
UPDATE Zarobki
SET Suma=Suma+100
FROM (SELECT ID_zamowienie AS ID FROM ZamowieniaKlient WHERE DATEDIFF(DD, Data_zlozenia_zamowienia, Data_wyslania_zamowienia)<8) Zab
WHERE Zarobki.ID_zamowienie=Zab.ID
--2) zmiana daty dla zam�wie� z marca w cenie 100-500 z�
UPDATE Zarobki
SET Data='2020-04-28 12:20:01'
WHERE MONTH(Data)=03 AND Suma>100 AND Suma<500
--3) zmiana sumy dla zam�wie� z kwietnia 
UPDATE Zarobki
SET Suma=Suma*0.9
WHERE MONTH(Data)=04

--tabela ZamowieniaKlient 
SELECT * FROM ZamowieniaKlient
--1)zmiana ceny dla zm�wie�, kt�re maj� ID parzyste i cen� mniejsz� ni� 100
UPDATE ZamowieniaKlient
SET Cena=Cena-10
WHERE ID_zamowienie%2=0 AND Cena<100
--2) zmiana szczeg��w dla zam�wien, kt�rych ID klienta jest parzyste oraz szczeg�y zaczynaj� si� na s
UPDATE ZamowieniaKlient
SET Szczegoly='BRAK'
WHERE Szczegoly LIKE 's%' AND ID_Klient%2=0
--3) zmiana daty wys�ania zam�wienia dla zam�wienia, kt�rego ID klienta jest parzyste
UPDATE ZamowieniaKlient
SET Data_wyslania_zamowienia='1990-01-01 01:01:01'
WHERE ID_Klient%2=0


--DELETE
--tabela ZamowieniaAsortyment
SELECT * FROM ZamowieniaAsortyment
--1) usuni�cie rekord�w, kt�rcyh realizacja by�a d�u�sza ni� 15 dni
DELETE FROM ZamowieniaAsortyment WHERE DATEDIFF(DD, Data_zlozenia_zamowienia, Data_odebrania_zamowienia)>15
--2) usuni�cie rekordu, kt�rego cena jest najmniejsza
DELETE FROM ZamowieniaAsortyment WHERE ID_zamowienie=(SELECT TOP 1 ID_zamowienie FROM ZamowieniaAsortyment ORDER BY Cena ASC )
--3) usuni�cie rekord�w, kt�re zosat�y z�o�one w 4 dniu miesi�ca i maj� parzyste ID
DELETE FROM ZamowieniaAsortyment WHERE DAY(Data_zlozenia_zamowienia)=04 AND ID_zamowienie%2=0
--DELETE FROM Pracownicy
--DELETE FROM Zarobki --
--DELETE FROM Oddzialy
--DELETE FROM Klient
--DELETE FROM ZamowieniaAsortyment
--DELETE FROM ZamowieniaKlient --
--DELETE FROM Wymiary


--CASCADE DELETE
--1) usuni�cie rekordu, dla kt�rego ID wymiar�w by�o r�wne 10
SELECT * FROM Wymiary
SELECT * FROM Klient
SELECT * FROM ZamowieniaKlient
SELECT * FROM Zarobki
DELETE FROM Wymiary WHERE ID_wymiary=10
--2) usuni�cie krawcowej, kt�ra najmniej zarobi�a
SELECT * FROM Zarobki
SELECT * FROM Pracownicy
DELETE FROM Pracownicy WHERE Pracownicy.ID_pracownik=(SELECT TOP 1 P.ID_pracownik FROM Pracownicy AS P JOIN Zarobki AS Z ON P.ID_pracownik=Z.ID_pracownik WHERE Stanowisko = 'Krawcowa' OR Stanowisko = 'Krawiec' GROUP BY P.ID_pracownik ORDER BY SUM(Z.Suma) ASC)
--3) usuni�cie danych wymiar�w, gdzie wzrost jest wi�kszy ni� 190
SELECT * FROM Wymiary
SELECT * FROM Klient
SELECT * FROM ZamowieniaKlient
SELECT * FROM Zarobki
DELETE FROM Wymiary WHERE Wzrost>=190
--4) usuni�cie pracownika,kt�ry przyj�� najwi�ksze zam�wienie w 2019
SELECT * FROM Pracownicy
SELECT * FROM Zarobki
DELETE FROM Pracownicy WHERE Pracownicy.ID_pracownik=(SELECT TOP 1 ID_pracownik FROM Zarobki WHERE YEAR(Data)=2019 ORDER BY Suma DESC )
--5) usun�� zam�wienia, kt�rych realizacja  by�a na minusie
SELECT * FROM ZamowieniaKlient
SELECT * FROM Zarobki
DELETE FROM ZamowieniaKlient WHERE ID_zamowienie IN (SELECT ID_zamowienie FROM ZamowieniaKlient WHERE DATEDIFF(DD, Data_zlozenia_zamowienia, Data_wyslania_zamowienia)<0)
--CASCADE UPDATE
--1) aktualizowanie id wymiar�w z 2 na 31
SELECT * FROM Wymiary
SELECT * FROM Klient
UPDATE Wymiary SET ID_wymiary=31 WHERE ID_wymiary=2
--2) zamiana ID pracownika, gdzie suma >=150
SELECT * FROM Zarobki
SELECT * FROM Pracownicy
UPDATE Pracownicy SET ID_pracownik=ID_pracownik+100 WHERE ID_pracownik IN (SELECT ID_pracownik FROM Zarobki WHERE Suma>=150)
--3) zmiana ID oddzia�u z 8 na 10
SELECT * FROM Pracownicy
SELECT * FROM Oddzialy
SELECT * FROM ZamowieniaAsortyment
UPDATE Oddzialy SET ID_oddzial=10 WHERE ID_oddzial=8
--4) zmiana ID klienta, gdy jesgo nazwisko zaczyna si� od k lub d
SELECT * FROM Klient
SELECT * FROM ZamowieniaKlient
UPDATE Klient SET ID_Klient=ID_Klient+200 WHERE Nazwisko LIKE 'D%' OR Nazwisko LIKE 'K%'
--5) zmiana ID zamowienia tam gdzie cena jest najni�sza
SELECT * FROM ZamowieniaKlient
SELECT * FROM Zarobki
UPDATE ZamowieniaKlient SET ID_zamowienie=ID_zamowienie+100 WHERE Cena=(SELECT TOP 1 Cena FROM ZamowieniaKlient ORDER BY Cena DESC)

