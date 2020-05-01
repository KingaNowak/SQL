-- 1) zyski danej krawcowej w danym miesi¹cu w danym rok
SELECT SUM(Z.Suma)*0.3 AS 'Zarobki krawcowej/ Krawca', P.ID_pracownik, P.Imie, P.Nazwisko FROM Zarobki AS Z LEFT JOIN Pracownicy AS P ON Z.ID_pracownik = P.ID_pracownik WHERE Z.Data>='2019-02-01 00:00:00' AND Z.Data<='2019-02-28 00:00:00' GROUP BY P.ID_pracownik, P.Imie, P.Nazwisko
-- 19) zyski danego pracownika administracyjnego w danym miesi¹cu w danym rok
SELECT SUM(Z.Suma)*0.3 AS 'Zarobki pracownika administracyjnego' FROM Zarobki AS Z LEFT JOIN Pracownicy AS P ON Z.ID_pracownik = P.ID_pracownik WHERE Z.Data>='2019-02-01 00:00:00' AND Z.Data<='2019-02-28 00:00:00' 
-- 2) zyski danego oddzia³u w danym miesi¹cu w danym roku
SELECT SUM(Z.Suma)*0.1 AS 'Zarobki Oddzia³u', O.ID_oddzial, O.Nazwa  FROM Zarobki AS Z JOIN Pracownicy AS P ON Z.ID_pracownik = P.ID_pracownik RIGHT JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial WHERE Z.Data>='2019-02-01 00:00:00' AND Z.Data<='2019-02-28 00:00:00' GROUP BY O.ID_oddzial, O.Nazwa
-- 13) oddzia³, który ma najwiêksze zyski
SELECT TOP 1 SUM(Z.Suma)*0.1 AS 'Zarobki Oddzia³u', O.ID_oddzial, O.Nazwa FROM Zarobki AS Z JOIN Pracownicy AS P ON Z.ID_pracownik = P.ID_pracownik JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial WHERE Z.Data>='2019-02-01 00:00:00' AND Z.Data<='2019-02-28 00:00:00' GROUP BY O.ID_oddzial, O.Nazwa ORDER BY SUM(Z.Suma) DESC
-- 13) oddzia³, który ma najmniejsze zyski
SELECT TOP 1 SUM(Z.Suma)*0.1 AS 'Zarobki Oddzia³u', O.ID_oddzial, O.Nazwa FROM Zarobki AS Z JOIN Pracownicy AS P ON Z.ID_pracownik = P.ID_pracownik JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial WHERE Z.Data>='2019-02-01 00:00:00' AND Z.Data<='2019-02-28 00:00:00' GROUP BY O.ID_oddzial, O.Nazwa ORDER BY SUM(Z.Suma) ASC
-- 4) które krawcowe s¹ odpowiedzialne za zamówienia na asortyment
SELECT O.Nazwa,  P.ID_oddzial, P.Imie, P.Nazwisko, P.Stanowisko FROM Pracownicy AS P JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial WHERE P.Asortyment=1 AND P.Stanowisko='Kierowniczka zmianowa' OR P.Stanowisko='Kierownik zmianowy'
-- 20) iloœæ wszystkich pracowników firmy
SELECT COUNT(*) AS 'Iloœæ pracowników' FROM Pracownicy
-- 3) iloœæ pracowników w danym oddziale
SELECT O.ID_oddzial, O.Nazwa,COUNT(P.ID_pracownik) AS 'Iloœæ pracowników' FROM Oddzialy AS O RIGHT JOIN Pracownicy AS P ON O.ID_oddzial=P.ID_oddzial GROUP BY O.Nazwa, O.ID_oddzial
-- 8) dane poszczególnych krawców
SELECT * FROM Pracownicy  WHERE Stanowisko= 'Kierowniczka zmianowa' OR Stanowisko= 'Kierownik zmianowy' OR Stanowisko= 'Krawcowa' OR Stanowisko= 'Krawiec'
-- 5) iloœæ zamówieñ realizowana przez dany oddzia³ w danym miesi¹cy w danym roku
SELECT COUNT(Z.ID_zamowienie) AS 'Iloœæ zamówieñ', O.ID_oddzial, O.Nazwa  FROM Zarobki AS Z JOIN Pracownicy AS P ON Z.ID_pracownik = P.ID_pracownik RIGHT JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial WHERE Z.Data>='2019-02-01 00:00:00' AND Z.Data<='2019-02-28 00:00:00' GROUP BY O.ID_oddzial, O.Nazwa 
-- 5) iloœæ zamówieñ realizowana przez dany oddzia³ w danym roku
SELECT COUNT(Z.ID_zamowienie) AS 'Iloœæ zamówieñ', O.ID_oddzial, O.Nazwa  FROM Zarobki AS Z JOIN Pracownicy AS P ON Z.ID_pracownik = P.ID_pracownik RIGHT JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial WHERE YEAR(Z.Data)= 2019  GROUP BY O.ID_oddzial, O.Nazwa 
-- 6) suma zamówieñ realizowanych przez dane oddzia³y w danym miesi¹cu w danym roku
SELECT SUM(Z.Suma) AS 'Zarobki Oddzia³u', O.ID_oddzial, O.Nazwa  FROM Zarobki AS Z JOIN Pracownicy AS P ON Z.ID_pracownik = P.ID_pracownik RIGHT JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial WHERE Z.Data>='2019-02-01 00:00:00' AND Z.Data<='2019-02-28 00:00:00' GROUP BY O.ID_oddzial, O.Nazwa 
-- 6) suma zamówieñ realizowanych przez dane oddzia³y w danym roku
SELECT SUM(Z.Suma) AS 'Zarobki Oddzia³u', O.ID_oddzial, O.Nazwa  FROM Zarobki AS Z JOIN Pracownicy AS P ON Z.ID_pracownik = P.ID_pracownik RIGHT JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial WHERE YEAR(Z.Data)=2019 GROUP BY O.ID_oddzial, O.Nazwa 
-- 18) kto jest pracownikiem adminitracyjnym i jakie pe³ni funkcje
SELECT P.Imie, P.Nazwisko, P.Stanowisko FROM Pracownicy AS P WHERE P.Stanowisko!='Kierownik zmianowy' AND P.Stanowisko!='Kierowniczka zmianowa' AND P.Stanowisko!='Krawcowa' AND P.Stanowisko!='Krawiec'
-- 17) œredni wzrost klientów pod wzglêdem p³ci
SELECT K.Plec, AVG(W.Wzrost) AS 'Œredni wzrost klientów' FROM Klient AS K JOIN Wymiary AS W ON K.ID_wymiary=W.ID_wymiary GROUP BY K.Plec
-- 16) kto sk³ada czêœciej zamówienia pod wzglêdem p³ci K/M 0/1
SELECT K.Plec, COUNT(ZK.ID_zamowienie) AS 'Iloœæ z³o¿onych zamówieñ' FROM Klient AS K JOIN ZamowieniaKlient AS ZK ON K.ID_Klient=ZK.ID_Klient GROUP BY K.Plec
-- 15) Udzia³ procentowy zatrudniownych osób w ca³ej firmie pod wzglêdem p³ci
SELECT P.Plec,  STR(ROUND(Count(*)*100.0/(SELECT COUNT(*) FROM Pracownicy),2),6,2)  FROM Pracownicy AS P GROUP BY P.Plec
-- 15) Udzia³ procentowy zatrudniownych osób w poszczególnych oddzia³ach pod wzglêdem p³ci
SELECT O.ID_oddzial, O.Nazwa, P.Plec,  STR(ROUND(Count(*)*100.0/(SELECT COUNT(*) FROM Pracownicy),2),6,2)  FROM Pracownicy AS P JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial GROUP BY O.ID_oddzial, O.Nazwa, P.Plec
-- 7) œredni czas realizacji zamówieñ w ca³ej firmie
SELECT AVG(DATEDIFF(DD,ZK.Data_zlozenia_zamowienia,ZK.Data_wyslania_zamowienia)) AS 'Œredni czas realizacji zamówieñ' FROM ZamowieniaKlient AS ZK 
-- 7) œredni czas realizacji zamówieñ w danym oddziale
SELECT P.ID_oddzial, AVG(DATEDIFF(DD,ZK.Data_zlozenia_zamowienia,ZK.Data_wyslania_zamowienia)) AS 'Œredni czas realizacji zamówieñ' FROM ZamowieniaKlient AS ZK JOIN Zarobki AS Z ON Z.ID_zamowienie=ZK.ID_zamowienie JOIN Pracownicy AS P ON Z.ID_pracownik=P.ID_pracownik GROUP BY P.ID_oddzial
-- 7) czas realizacji poszczególnych zamówieñ
SELECT DATEDIFF(DD,ZK.Data_zlozenia_zamowienia,ZK.Data_wyslania_zamowienia) AS 'Czas realizacji zamówienia' FROM ZamowieniaKlient AS ZK 
-- 11) ile zamówiñ przyjmuje dana krawcowa w danym miesi¹cu w danym roku
SELECT Z.ID_pracownik, P.Imie, P.Nazwisko, COUNT(Z.ID_pracownik) AS 'Iloœæ zamówieñ' FROM Pracownicy AS P JOIN Zarobki AS Z ON Z.ID_pracownik=P.ID_pracownik JOIN ZamowieniaKlient AS ZK ON ZK.ID_zamowienie=Z.ID_zamowienie WHERE MONTH(ZK.Data_zlozenia_zamowienia)=2 AND YEAR(ZK.Data_zlozenia_zamowienia)=2019 GROUP BY Z.ID_pracownik, P.Imie, P.Nazwisko
-- 12) która krawcowa ma najwiêcej zamówieñ w ca³ej firmie
SELECT TOP 1 Z.ID_pracownik, P.Imie, P.Nazwisko, COUNT(Z.ID_zamowienie) AS 'Iloœæ zamówieñ' FROM ZamowieniaKlient AS ZK JOIN Zarobki AS Z ON ZK.ID_zamowienie=Z.ID_zamowienie JOIN Pracownicy AS P ON Z.ID_pracownik=P.ID_pracownik WHERE MONTH(ZK.Data_zlozenia_zamowienia)=2 AND YEAR(ZK.Data_zlozenia_zamowienia)=2019 GROUP BY Z.ID_pracownik, P.Imie, P.Nazwisko ORDER BY COUNT(ZK.ID_zamowienie) DESC
-- 12) która krawcowa przyjmuje najwiêcej zamówieñ w danym oddziale w danym miesi¹cu w danym roku
SELECT MAX(Ilosc) AS 'Iloœæ', Odd AS 'Oddzia³', MAX(I) AS 'Imiê', MAX(N) AS 'Nazwisko' FROM ( SELECT COUNT(ZK.ID_zamowienie) AS Ilosc, P.ID_oddzial AS Odd, P.Imie AS I, P.Nazwisko AS N FROM ZamowieniaKlient AS ZK JOIN Zarobki AS Z ON ZK.ID_zamowienie=Z.ID_zamowienie JOIN Pracownicy AS P ON Z.ID_pracownik=P.ID_pracownik  WHERE MONTH(ZK.Data_zlozenia_zamowienia)=2 AND YEAR(ZK.Data_zlozenia_zamowienia)=2019 GROUP BY P.Imie, P.Nazwisko, P.ID_oddzial) zk GROUP BY Odd 
-- 9) czy klienci sk³adaj¹ wiêcej ni¿ jedno zamówienie
SELECT K.ID_Klient, K.Imie, K.Nazwisko, COUNT(ZK.ID_Klient) AS 'Iloœæ zamówieñ' FROM Klient AS K JOIN ZamowieniaKlient AS ZK ON K.ID_Klient=ZK.ID_Klient WHERE MONTH(ZK.Data_zlozenia_zamowienia)=2 AND YEAR(ZK.Data_zlozenia_zamowienia)=2019 GROUP BY K.ID_Klient, K.Imie, K.Nazwisko HAVING COUNT(ZK.ID_Klient)>1
-- 10) 50 najaktywniejsi klienci
SELECT TOP 50 K.ID_Klient, K.Imie, K.Nazwisko, COUNT(ZK.ID_Klient) AS 'Iloœæ zamówieñ' FROM Klient AS K JOIN ZamowieniaKlient AS ZK ON K.ID_Klient=ZK.ID_Klient WHERE MONTH(ZK.Data_zlozenia_zamowienia)=2 AND YEAR(ZK.Data_zlozenia_zamowienia)=2019 GROUP BY K.ID_Klient, K.Imie, K.Nazwisko ORDER BY COUNT(ZK.ID_zamowienie) DESC
-- 14) œredni wiek zatrudnionych osób w ca³ej formie
SELECT AVG(DATEDIFF(YY,P.Data_urodzenia, GETDATE())) AS 'Œredni wiek' FROM Pracownicy AS P
-- 14) œredni wiek zatrudnionych osób w poszczególnych oddzia³ach
SELECT O.ID_oddzial, O.Nazwa,AVG(DATEDIFF(YY,P.Data_urodzenia, GETDATE())) AS 'Œredni wiek' FROM Pracownicy AS P JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial GROUP BY O.ID_oddzial, O.Nazwa
-- 14) œredni wiek zatrudnionych osób w ca³ej formie w zale¿noœci od p³ci
SELECT P.Plec,AVG(DATEDIFF(YY,P.Data_urodzenia, GETDATE())) AS 'Œredni wiek' FROM Pracownicy AS P GROUP BY P.Plec
-- 14) œredni wiek zatrudnionych osób w poszczególnych oddzia³ach w zale¿noœci od p³ci
SELECT O.ID_oddzial, O.Nazwa, P.Plec, AVG(DATEDIFF(YY,P.Data_urodzenia, GETDATE())) AS 'Œredni wiek' FROM Pracownicy AS P JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial GROUP BY P.Plec, O.ID_oddzial, O.Nazwa
