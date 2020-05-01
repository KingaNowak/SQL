--CREATE DATABASE Zak³adKrawiecki
CREATE TABLE [Wymiary] (
  [ID_wymiary] int PRIMARY KEY NOT NULL,
  [Wzrost] int NOT NULL,
  [Obwod_Klatka_Piersiowa] int NOT NULL,
  [Obwod_Biodra] int NOT NULL,
  [Obwod_Talia] int NOT NULL,
  [Dlugosc_Reka] int NOT NULL,
  [Dlugosc_Noga] int NOT NULL,
  [Obwod_Nadgarstek] int NOT NULL,
  [Obwod_Kostka] int NOT NULL,
  [Obwod_Lydka] int NOT NULL,
  [Obwod_Udo] int NOT NULL,
  [Obwod_Szyja] int NOT NULL,
  [Dlugosc_Klatka_Piersiowa] int NOT NULL
)
GO

CREATE TABLE [Klient] (
  [ID_Klient] int PRIMARY KEY NOT NULL,
  [Imie] nchar(100) NOT NULL,
  [Nazwisko] nchar(100) NOT NULL,
  [Nr_telefonu] int NULL,
  [Miasto] nchar(500) NOT NULL,
  [Plec] bit NOT NULL,
  [ID_wymiary] int NOT NULL
)
GO

CREATE TABLE [Oddzialy] (
  [ID_oddzial] int PRIMARY KEY NOT NULL,
  [Nazwa] nchar(100) NOT NULL
)
GO

CREATE TABLE [ZamowieniaAsortyment] (
  [ID_zamowienie] int PRIMARY KEY NOT NULL,
  [Data_zlozenia_zamowienia] datetime NOT NULL,
  [Data_odebrania_zamowienia] datetime NULL,
  [Cena] float NOT NULL,
  [Szczegoly] nchar(1000) NOT NULL,
  [ID_oddzial] int NOT NULL
)
GO

CREATE TABLE [Pracownicy] (
  [ID_pracownik] int PRIMARY KEY NOT NULL,
  [Imie] nchar(100) NOT NULL,
  [Nazwisko] nchar(100) NOT NULL,
  [Nr_telefonu] int NULL,
  [Data_urodzenia] datetime NOT NULL,
  [Asortyment] bit NOT NULL,
  [Stanowisko] nchar(100) NOT NULL,
  [Plec] bit NOT NULL,
  [ID_oddzial] int NOT NULL
)
GO

CREATE TABLE [ZamowieniaKlient] (
  [ID_zamowienie] int PRIMARY KEY NOT NULL,
  [Cena] float NOT NULL,
  [Szczegoly] nchar(1000) NOT NULL,
  [Data_zlozenia_zamowienia] datetime NOT NULL,
  [Data_wyslania_zamowienia] datetime NULL,
  [ID_Klient] int NOT NULL
)
GO

CREATE TABLE [Zarobki] (
  [ID_zarobki] int PRIMARY KEY NOT NULL,
  [Data] datetime NOT NULL,
  [Suma] float NOT NULL,
  [ID_pracownik] int NOT NULL,
  [ID_zamowienie] int NOT NULL
)
GO

ALTER TABLE [ZamowieniaAsortyment] ADD FOREIGN KEY ([ID_oddzial]) REFERENCES [Oddzialy] ([ID_oddzial]) ON UPDATE CASCADE ON DELETE CASCADE
GO

ALTER TABLE [Pracownicy] ADD FOREIGN KEY ([ID_oddzial]) REFERENCES [Oddzialy] ([ID_oddzial]) ON UPDATE CASCADE ON DELETE CASCADE
GO

ALTER TABLE [Zarobki] ADD FOREIGN KEY ([ID_pracownik]) REFERENCES [Pracownicy] ([ID_pracownik]) ON UPDATE CASCADE ON DELETE CASCADE
GO

ALTER TABLE [Zarobki] ADD FOREIGN KEY ([ID_zamowienie]) REFERENCES [ZamowieniaKlient] ([ID_zamowienie]) ON UPDATE CASCADE ON DELETE CASCADE
GO

ALTER TABLE [Klient] ADD FOREIGN KEY ([ID_wymiary]) REFERENCES [Wymiary] ([ID_wymiary]) ON UPDATE CASCADE ON DELETE CASCADE
GO

ALTER TABLE [ZamowieniaKlient] ADD FOREIGN KEY ([ID_Klient]) REFERENCES [Klient] ([ID_Klient]) ON UPDATE CASCADE ON DELETE CASCADE
GO

