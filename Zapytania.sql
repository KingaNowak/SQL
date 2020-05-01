-- 1) zyski danej krawcowej w danym miesi�cu w danym rok
SELECT SUM(Z.Suma)*0.3 AS 'Zarobki krawcowej/ Krawca', P.ID_pracownik, P.Imie, P.Nazwisko FROM Zarobki AS Z LEFT JOIN Pracownicy AS P ON Z.ID_pracownik = P.ID_pracownik WHERE Z.Data>='2019-02-01 00:00:00' AND Z.Data<='2019-02-28 00:00:00' GROUP BY P.ID_pracownik, P.Imie, P.Nazwisko
-- 19) zyski danego pracownika administracyjnego w danym miesi�cu w danym rok
SELECT SUM(Z.Suma)*0.3 AS 'Zarobki pracownika administracyjnego' FROM Zarobki AS Z LEFT JOIN Pracownicy AS P ON Z.ID_pracownik = P.ID_pracownik WHERE Z.Data>='2019-02-01 00:00:00' AND Z.Data<='2019-02-28 00:00:00' 
-- 2) zyski danego oddzia�u w danym miesi�cu w danym roku
SELECT SUM(Z.Suma)*0.1 AS 'Zarobki Oddzia�u', O.ID_oddzial, O.Nazwa  FROM Zarobki AS Z JOIN Pracownicy AS P ON Z.ID_pracownik = P.ID_pracownik RIGHT JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial WHERE Z.Data>='2019-02-01 00:00:00' AND Z.Data<='2019-02-28 00:00:00' GROUP BY O.ID_oddzial, O.Nazwa
-- 13) oddzia�, kt�ry ma najwi�ksze zyski
SELECT TOP 1 SUM(Z.Suma)*0.1 AS 'Zarobki Oddzia�u', O.ID_oddzial, O.Nazwa FROM Zarobki AS Z JOIN Pracownicy AS P ON Z.ID_pracownik = P.ID_pracownik JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial WHERE Z.Data>='2019-02-01 00:00:00' AND Z.Data<='2019-02-28 00:00:00' GROUP BY O.ID_oddzial, O.Nazwa ORDER BY SUM(Z.Suma) DESC
-- 13) oddzia�, kt�ry ma najmniejsze zyski
SELECT TOP 1 SUM(Z.Suma)*0.1 AS 'Zarobki Oddzia�u', O.ID_oddzial, O.Nazwa FROM Zarobki AS Z JOIN Pracownicy AS P ON Z.ID_pracownik = P.ID_pracownik JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial WHERE Z.Data>='2019-02-01 00:00:00' AND Z.Data<='2019-02-28 00:00:00' GROUP BY O.ID_oddzial, O.Nazwa ORDER BY SUM(Z.Suma) ASC
-- 4) kt�re krawcowe s� odpowiedzialne za zam�wienia na asortyment
SELECT O.Nazwa,  P.ID_oddzial, P.Imie, P.Nazwisko, P.Stanowisko FROM Pracownicy AS P JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial WHERE P.Asortyment=1 AND P.Stanowisko='Kierowniczka zmianowa' OR P.Stanowisko='Kierownik zmianowy'
-- 20) ilo�� wszystkich pracownik�w firmy
SELECT COUNT(*) AS 'Ilo�� pracownik�w' FROM Pracownicy
-- 3) ilo�� pracownik�w w danym oddziale
SELECT O.ID_oddzial, O.Nazwa,COUNT(P.ID_pracownik) AS 'Ilo�� pracownik�w' FROM Oddzialy AS O RIGHT JOIN Pracownicy AS P ON O.ID_oddzial=P.ID_oddzial GROUP BY O.Nazwa, O.ID_oddzial
-- 8) dane poszczeg�lnych krawc�w
SELECT * FROM Pracownicy  WHERE Stanowisko= 'Kierowniczka zmianowa' OR Stanowisko= 'Kierownik zmianowy' OR Stanowisko= 'Krawcowa' OR Stanowisko= 'Krawiec'
-- 5) ilo�� zam�wie� realizowana przez dany oddzia� w danym miesi�cy w danym roku
SELECT COUNT(Z.ID_zamowienie) AS 'Ilo�� zam�wie�', O.ID_oddzial, O.Nazwa  FROM Zarobki AS Z JOIN Pracownicy AS P ON Z.ID_pracownik = P.ID_pracownik RIGHT JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial WHERE Z.Data>='2019-02-01 00:00:00' AND Z.Data<='2019-02-28 00:00:00' GROUP BY O.ID_oddzial, O.Nazwa 
-- 5) ilo�� zam�wie� realizowana przez dany oddzia� w danym roku
SELECT COUNT(Z.ID_zamowienie) AS 'Ilo�� zam�wie�', O.ID_oddzial, O.Nazwa  FROM Zarobki AS Z JOIN Pracownicy AS P ON Z.ID_pracownik = P.ID_pracownik RIGHT JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial WHERE YEAR(Z.Data)= 2019  GROUP BY O.ID_oddzial, O.Nazwa 
-- 6) suma zam�wie� realizowanych przez dane oddzia�y w danym miesi�cu w danym roku
SELECT SUM(Z.Suma) AS 'Zarobki Oddzia�u', O.ID_oddzial, O.Nazwa  FROM Zarobki AS Z JOIN Pracownicy AS P ON Z.ID_pracownik = P.ID_pracownik RIGHT JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial WHERE Z.Data>='2019-02-01 00:00:00' AND Z.Data<='2019-02-28 00:00:00' GROUP BY O.ID_oddzial, O.Nazwa 
-- 6) suma zam�wie� realizowanych przez dane oddzia�y w danym roku
SELECT SUM(Z.Suma) AS 'Zarobki Oddzia�u', O.ID_oddzial, O.Nazwa  FROM Zarobki AS Z JOIN Pracownicy AS P ON Z.ID_pracownik = P.ID_pracownik RIGHT JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial WHERE YEAR(Z.Data)=2019 GROUP BY O.ID_oddzial, O.Nazwa 
-- 18) kto jest pracownikiem adminitracyjnym i jakie pe�ni funkcje
SELECT P.Imie, P.Nazwisko, P.Stanowisko FROM Pracownicy AS P WHERE P.Stanowisko!='Kierownik zmianowy' AND P.Stanowisko!='Kierowniczka zmianowa' AND P.Stanowisko!='Krawcowa' AND P.Stanowisko!='Krawiec'
-- 17) �redni wzrost klient�w pod wzgl�dem p�ci
SELECT K.Plec, AVG(W.Wzrost) AS '�redni wzrost klient�w' FROM Klient AS K JOIN Wymiary AS W ON K.ID_wymiary=W.ID_wymiary GROUP BY K.Plec
-- 16) kto sk�ada cz�ciej zam�wienia pod wzgl�dem p�ci K/M 0/1
SELECT K.Plec, COUNT(ZK.ID_zamowienie) AS 'Ilo�� z�o�onych zam�wie�' FROM Klient AS K JOIN ZamowieniaKlient AS ZK ON K.ID_Klient=ZK.ID_Klient GROUP BY K.Plec
-- 15) Udzia� procentowy zatrudniownych os�b w ca�ej firmie pod wzgl�dem p�ci
SELECT P.Plec,  STR(ROUND(Count(*)*100.0/(SELECT COUNT(*) FROM Pracownicy),2),6,2)  FROM Pracownicy AS P GROUP BY P.Plec
-- 15) Udzia� procentowy zatrudniownych os�b w poszczeg�lnych oddzia�ach pod wzgl�dem p�ci
SELECT O.ID_oddzial, O.Nazwa, P.Plec,  STR(ROUND(Count(*)*100.0/(SELECT COUNT(*) FROM Pracownicy),2),6,2)  FROM Pracownicy AS P JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial GROUP BY O.ID_oddzial, O.Nazwa, P.Plec
-- 7) �redni czas realizacji zam�wie� w ca�ej firmie
SELECT AVG(DATEDIFF(DD,ZK.Data_zlozenia_zamowienia,ZK.Data_wyslania_zamowienia)) AS '�redni czas realizacji zam�wie�' FROM ZamowieniaKlient AS ZK 
-- 7) �redni czas realizacji zam�wie� w danym oddziale
SELECT P.ID_oddzial, AVG(DATEDIFF(DD,ZK.Data_zlozenia_zamowienia,ZK.Data_wyslania_zamowienia)) AS '�redni czas realizacji zam�wie�' FROM ZamowieniaKlient AS ZK JOIN Zarobki AS Z ON Z.ID_zamowienie=ZK.ID_zamowienie JOIN Pracownicy AS P ON Z.ID_pracownik=P.ID_pracownik GROUP BY P.ID_oddzial
-- 7) czas realizacji poszczeg�lnych zam�wie�
SELECT DATEDIFF(DD,ZK.Data_zlozenia_zamowienia,ZK.Data_wyslania_zamowienia) AS 'Czas realizacji zam�wienia' FROM ZamowieniaKlient AS ZK 
-- 11) ile zam�wi� przyjmuje dana krawcowa w danym miesi�cu w danym roku
SELECT Z.ID_pracownik, P.Imie, P.Nazwisko, COUNT(Z.ID_pracownik) AS 'Ilo�� zam�wie�' FROM Pracownicy AS P JOIN Zarobki AS Z ON Z.ID_pracownik=P.ID_pracownik JOIN ZamowieniaKlient AS ZK ON ZK.ID_zamowienie=Z.ID_zamowienie WHERE MONTH(ZK.Data_zlozenia_zamowienia)=2 AND YEAR(ZK.Data_zlozenia_zamowienia)=2019 GROUP BY Z.ID_pracownik, P.Imie, P.Nazwisko
-- 12) kt�ra krawcowa ma najwi�cej zam�wie� w ca�ej firmie
SELECT TOP 1 Z.ID_pracownik, P.Imie, P.Nazwisko, COUNT(Z.ID_zamowienie) AS 'Ilo�� zam�wie�' FROM ZamowieniaKlient AS ZK JOIN Zarobki AS Z ON ZK.ID_zamowienie=Z.ID_zamowienie JOIN Pracownicy AS P ON Z.ID_pracownik=P.ID_pracownik WHERE MONTH(ZK.Data_zlozenia_zamowienia)=2 AND YEAR(ZK.Data_zlozenia_zamowienia)=2019 GROUP BY Z.ID_pracownik, P.Imie, P.Nazwisko ORDER BY COUNT(ZK.ID_zamowienie) DESC
-- 12) kt�ra krawcowa przyjmuje najwi�cej zam�wie� w danym oddziale w danym miesi�cu w danym roku
SELECT MAX(Ilosc) AS 'Ilo��', Odd AS 'Oddzia�', MAX(I) AS 'Imi�', MAX(N) AS 'Nazwisko' FROM ( SELECT COUNT(ZK.ID_zamowienie) AS Ilosc, P.ID_oddzial AS Odd, P.Imie AS I, P.Nazwisko AS N FROM ZamowieniaKlient AS ZK JOIN Zarobki AS Z ON ZK.ID_zamowienie=Z.ID_zamowienie JOIN Pracownicy AS P ON Z.ID_pracownik=P.ID_pracownik  WHERE MONTH(ZK.Data_zlozenia_zamowienia)=2 AND YEAR(ZK.Data_zlozenia_zamowienia)=2019 GROUP BY P.Imie, P.Nazwisko, P.ID_oddzial) zk GROUP BY Odd 
-- 9) czy klienci sk�adaj� wi�cej ni� jedno zam�wienie
SELECT K.ID_Klient, K.Imie, K.Nazwisko, COUNT(ZK.ID_Klient) AS 'Ilo�� zam�wie�' FROM Klient AS K JOIN ZamowieniaKlient AS ZK ON K.ID_Klient=ZK.ID_Klient WHERE MONTH(ZK.Data_zlozenia_zamowienia)=2 AND YEAR(ZK.Data_zlozenia_zamowienia)=2019 GROUP BY K.ID_Klient, K.Imie, K.Nazwisko HAVING COUNT(ZK.ID_Klient)>1
-- 10) 50 najaktywniejsi klienci
SELECT TOP 50 K.ID_Klient, K.Imie, K.Nazwisko, COUNT(ZK.ID_Klient) AS 'Ilo�� zam�wie�' FROM Klient AS K JOIN ZamowieniaKlient AS ZK ON K.ID_Klient=ZK.ID_Klient WHERE MONTH(ZK.Data_zlozenia_zamowienia)=2 AND YEAR(ZK.Data_zlozenia_zamowienia)=2019 GROUP BY K.ID_Klient, K.Imie, K.Nazwisko ORDER BY COUNT(ZK.ID_zamowienie) DESC
-- 14) �redni wiek zatrudnionych os�b w ca�ej formie
SELECT AVG(DATEDIFF(YY,P.Data_urodzenia, GETDATE())) AS '�redni wiek' FROM Pracownicy AS P
-- 14) �redni wiek zatrudnionych os�b w poszczeg�lnych oddzia�ach
SELECT O.ID_oddzial, O.Nazwa,AVG(DATEDIFF(YY,P.Data_urodzenia, GETDATE())) AS '�redni wiek' FROM Pracownicy AS P JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial GROUP BY O.ID_oddzial, O.Nazwa
-- 14) �redni wiek zatrudnionych os�b w ca�ej formie w zale�no�ci od p�ci
SELECT P.Plec,AVG(DATEDIFF(YY,P.Data_urodzenia, GETDATE())) AS '�redni wiek' FROM Pracownicy AS P GROUP BY P.Plec
-- 14) �redni wiek zatrudnionych os�b w poszczeg�lnych oddzia�ach w zale�no�ci od p�ci
SELECT O.ID_oddzial, O.Nazwa, P.Plec, AVG(DATEDIFF(YY,P.Data_urodzenia, GETDATE())) AS '�redni wiek' FROM Pracownicy AS P JOIN Oddzialy AS O ON P.ID_oddzial=O.ID_oddzial GROUP BY P.Plec, O.ID_oddzial, O.Nazwa
