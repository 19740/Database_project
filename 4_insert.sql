--table address
INSERT INTO adres(kod, numer, ulica, miejscowosc) VALUES  ('80-253', '12', 'Gotycka', 'Gdansk');
INSERT INTO adres(kod, numer, ulica, miejscowosc) VALUES  ('80-001', '6', 'Trakt sw. Wojciecha', 'Gdansk');
INSERT INTO adres(kod, numer, ulica, miejscowosc) VALUES ( '80-690', '87/1', 'Frezjowa', 'Gdansk');
INSERT INTO adres(kod, numer, ulica, miejscowosc) VALUES ('80-366', '4a', 'Jagiellonska', 'Gdansk');
INSERT INTO adres(kod, numer, ulica, miejscowosc) VALUES ( '60-778', '1/2', 'Orzeszkowej Elizy', 'Poznan');
INSERT INTO adres(kod, numer, ulica, miejscowosc) VALUES ( '30-001', '19/3', 'Kammienna', 'Krakow');
INSERT INTO adres(kod, numer, ulica, miejscowosc) VALUES ( '01-475', '45b', 'Radziejowicka', 'Warszawa');
INSERT INTO adres(kod, numer, ulica, miejscowosc) VALUES ( '81-547', '45b', 'Folwarcza', 'Gdynia');
INSERT INTO adres(kod, numer, ulica, miejscowosc) VALUES ( '81-303', '4', 'Kielecka', 'Gdynia');
INSERT INTO adres(kod, numer, ulica, miejscowosc) VALUES ( '32-020', '19/2a', 'Legionow', 'Wieliczka');
INSERT INTO adres(kod, numer, ulica, miejscowosc) VALUES ('31-020', '4b', 'Pilsudskiego Jozefa', 'Wieliczka');
INSERT INTO adres(kod, numer, ulica, miejscowosc) VALUES ('10-001', '45b', 'Pienieznego', 'Olsztyn');




--table author
INSERT INTO autor(imie, nazwisko) VALUES ('Fiodor', 'Dostojewski');
INSERT INTO autor(imie, nazwisko) VALUES ('Maggie', 'Stiefvater');
INSERT INTO autor(imie, nazwisko) VALUES ('Hannu', 'Rajaniemi');
INSERT INTO autor(imie, nazwisko) VALUES ('Jackson', 'Pearce');
INSERT INTO autor(imie, nazwisko) VALUES ('Joe', 'Abercrombie');
INSERT INTO autor(imie, nazwisko) VALUES ('Neil', 'Gaiman');


--table category
INSERT INTO kategoria( nazwa) VALUES ( 'Fantasy');
INSERT INTO kategoria( nazwa) VALUES ('Sci-Fi');
INSERT INTO kategoria( nazwa) VALUES ( 'Kryminal');
INSERT INTO kategoria( nazwa) VALUES ( 'Literatura piekna');
INSERT INTO kategoria( nazwa) VALUES ( 'Romans');
INSERT INTO kategoria( nazwa) VALUES ( 'Horror');

--table status
INSERT INTO stan(nazwa,opis) VALUES ('Z�o�enie zam�wienia.','Twoje zam�wienie zosta�o z�o�one.');
INSERT INTO stan(nazwa,opis) VALUES ('Oczekiwanie na zaplate.','Twoje zam�wienie oczekuje na zaplate.');
INSERT INTO stan(nazwa,opis) VALUES ('Oplacono zamowienie.','Twoje zam�wienie zostalo oplacone.');
INSERT INTO stan(nazwa,opis) VALUES ('Przygotowanie zamowienia.','Twoje zam�wienie jest kompletowane.');
INSERT INTO stan(nazwa,opis) VALUES ('Wyslanie zamowienia.','Twoje zam�wienie zostalo wyslane. Niedlugo kurier dostarczy je do Ciebie!');
INSERT INTO Stan(nazwa,opis) VALUES ('Dostarczenie zamowienia.','Twoje zam�wienie jest juz u Ciebie!');
INSERT INTO stan(nazwa,opis) VALUES ('Proba dostarczenia zamowienia.','Twoje zam�wienie nie zostalo przez Ciebie odebrane. Kurier jutro ponowi probe!');
INSERT INTO stan(nazwa,opis) VALUES ('Odeslanie zamowienia.','Twoje zam�wienie zostalo przez Ciebie zwrocone.');


--table series
INSERT INTO seria( nazwa, ilosc_tomow) VALUES ( 'The raven cycle', 4);
INSERT INTO seria( nazwa, ilosc_tomow) VALUES ( 'Jean le Flambeur', 3);
INSERT INTO seria( nazwa, ilosc_tomow) VALUES ( 'Pierwsze prawo', 3);

--table publisher
INSERT INTO wydawca(nazwa) VALUES ( 'Wydawnictwo MG');
INSERT INTO wydawca(nazwa) VALUES ( 'Uroboros');
INSERT INTO wydawca(nazwa) VALUES ( 'MAG');
INSERT INTO wydawca(nazwa) VALUES ( 'Wilga');


--table employee
INSERT INTO pracownik(imie, nazwisko, telefon, email, pesel, data_zatrudnienia, pensja, adres_id) VALUES ('Agata', 'Nowak', '123456789', 'ANOWAK@gmail.com', '00223344556', '2016-01-21', 5000, 1); 
INSERT INTO pracownik(imie, nazwisko, telefon, email, pesel, data_zatrudnienia, pensja, adres_id) VALUES ('Kinga', 'Nowak', '987654321', 'kingaN@gmail.com', '00345678909', '2019-11-12', 3500, 1); 
INSERT INTO pracownik(imie, nazwisko, telefon, email, pesel, data_zatrudnienia, pensja, adres_id) VALUES ('Norbert', 'Kowalski', '123123123', 'NorbiKowal@wp.pl', '00876543212', '2020-05-03', 4000, 2); 
INSERT INTO pracownik(imie, nazwisko, telefon, email, pesel, data_zatrudnienia, pensja, adres_id) VALUES ('Stanislaw', 'Kowal', '456456456', 'Stan@tlen.pl', '00334556778', '2021-11-04', 2500, 8); 
INSERT INTO pracownik(imie, nazwisko, telefon, email, pesel, data_zatrudnienia, pensja, adres_id) VALUES ('Karolina', 'Czapla', '789987789', 'Czapla12@gmail.com', '00473829105', '2018-02-01', 3000, 4); 
INSERT INTO pracownik(imie, nazwisko, telefon, email, pesel, data_zatrudnienia, pensja, adres_id) VALUES ('Karol', 'Zebra', '099887765', 'Karol1@gmail.com', '01928374655', '2020-03-30', 4000, 9); 



--table customer
INSERT INTO klient(adres_id, imie, nazwisko, telefon, email, haslo) VALUES (3, 'Paulina', 'Niska', '135790864', 'Paula13@onet.pl', 'Paula12');
INSERT INTO klient(adres_id, imie, nazwisko, telefon, email, haslo) VALUES (6, 'Karol', 'Wysoki', '123321123', 'KaroW@gmail.com', 'WKaro9');
INSERT INTO klient(adres_id, imie, nazwisko, telefon,email, haslo) VALUES (5, 'Kamil', 'Kula', '234345567', 'KKula@gmail.com', 'haslo123');
INSERT INTO klient(adres_id, imie, nazwisko, telefon,email, haslo) VALUES (10, 'Dorota', 'Tarota', '097986875', 'DamaKier@onet.pl', 'haslo7');
INSERT INTO klient(adres_id, imie, nazwisko, telefon, email, haslo) VALUES (12, 'Natalia', 'Lin', '456543234', 'Lin123@gmail.com', 'lin321');
INSERT INTO klient(adres_id, imie, nazwisko, telefon,email, haslo) VALUES (11, 'Bartek', 'Lis', '123987456', 'Lis321@gmail.com', 'lis123');


--table order
INSERT INTO zamowienie(klient_id, pracownik_id, cena_dostawy, data_zamowienia) VALUES (1, 6, NULL, '2020-08-01');
INSERT INTO zamowienie(klient_id, pracownik_id, cena_dostawy, data_zamowienia) VALUES (3, 4, 12.99, '2020-10-08');
INSERT INTO zamowienie(klient_id, pracownik_id, cena_dostawy, data_zamowienia) VALUES (3, 1, 8.99, '2021-01-05');
INSERT INTO zamowienie(klient_id, pracownik_id, cena_dostawy, data_zamowienia) VALUES (4, 2, 16.99, '2021-03-15');
INSERT INTO zamowienie(klient_id, pracownik_id, cena_dostawy, data_zamowienia) VALUES (2, 5, NULL, '2021-06-22');
INSERT INTO zamowienie(klient_id, pracownik_id, cena_dostawy, data_zamowienia) VALUES (5, 3, 12.99, '2021-09-01');





--table status of the order
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (1, 1, '2020-08-01');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (2, 1, '2020-08-01');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (3, 1, '2020-08-01');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (4, 1, '2020-08-02');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (5, 1, '2020-08-03');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (6, 1, '2020-08-06');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (1, 2, '2020-10-08');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (2, 2, '2020-10-08');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (3, 2, '2020-10-09');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (4, 2, '2020-10-09');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (5, 2, '2020-10-10');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (6, 2, '2020-10-12');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (1, 3, '2021-01-05');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (2, 3, '2021-01-05');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (3, 3, '2021-01-05');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (4, 3, '2021-01-06');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (5, 3, '2021-01-06');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (7, 3, '2021-01-09');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (6, 3, '2021-01-10');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (1, 4, '2021-03-15');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (2, 4, '2021-03-15');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (3, 4, '2021-03-15');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (4, 4, '2021-03-15');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (5, 4, '2021-03-16');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (6, 4, '2021-03-17');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (1, 5, '2021-06-22');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (2, 5, '2021-06-22');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (3, 5, '2021-06-23');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (4, 5, '2021-06-24');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (5, 5, '2021-06-24');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (6, 5, '2021-06-29');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (8, 5, '2021-07-02');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (1, 6, '2021-09-01');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (2, 6, '2021-09-01');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (3, 6, '2021-09-02');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (4, 6, '2021-09-02');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (5, 6, '2021-09-03');
INSERT INTO stan_zamowienia(stan_id, zamowienie_id, data_zmiany) VALUES (6, 6, '2021-09-07');



--table book
INSERT INTO ksiazka(wydawca_id, seria_id, kategoria_id, autor_id, opis, nazwa, ilosc_stron, data_wydania, ilosc_sztuk, cena_netto, podatek) VALUES (1, 1, 4, 1, 'Bia�e noce � to losy naiwnego marzyciela pogr��onego we w�asnym �wiecie, przechadzaj�cego si� ca�ymi dniami po Petersburgu, samotnie, poza spo�ecze�stwem. Na mo�cie spotyka kobiet�, to jedyna istota, kt�ra go s�ucha a p�niej on jej s�ucha i�
Cudza �ona � m�czyzna kr��y noc� pod oknami obcej kamienicy. Szuka pewnej damy. Jest to �ona, cudza �ona, jej m�� czatuje na mo�cie Wozniesie�skim, aby j� przy�apa�, ale nie mo�e si� zdecydowa�
Sen wujaszka � przyjazd do miasteczka petersburskiej guberni dziwacznego, starego, niespe�na rozumu ksi�cia wywo�uje ogromne poruszenie w�r�d miejscowych plotkarek i pa� domu. Jedna z nich pr�buje wyda� swoj� c�rk� za ksi�cia�
Krokodyl � opowie�� o tym, jak pewien pan zosta� w po�kni�ty przez krokodyla �ywcem, ca�y, bez reszty, i co z tego wynik�o...', 'Opowie�ci: Bia�e noce, Cudza �ona, Sen wujaszka, Krokodyl', 600, '2020-09-16', 122, 35.99, 5);
INSERT INTO ksiazka(wydawca_id, seria_id, kategoria_id, autor_id, opis, nazwa, ilosc_stron, data_wydania, ilosc_sztuk, cena_netto, podatek) VALUES (2, 1, 1, 2, 'Pierwszy tom magicznej sagi. Jedna dziewczyna i trzech ch�opak�w. Blue pochodzi z rodziny wr�ek, jest medium do kontakt�w ze �wiatem zmar�ych. Gansey, Adam i Ronan, trzej przyjaciele w elitarnej szko�y dla ch�opc�w, obsesyjnie poszukuj� tajemniczych linii mocy legendarnego Kr�la Kruk�w - Glendowera. Z ich powodu pozornie ciche i spokojne miasteczko staje si� sceneri� niezwyk�ych wydarze�. Gdy razem z Blue trafi� do magicznego lasu, gdzie czas p�ata figle, nic ju� nie b�dzie takie samo... Przera�aj�ce tajemnice, mroczne rytua�y, stare przepowiednie, wizje, duchy, ofiary, a to dopiero pocz�tek tej historii...', 'Kr�l kruk�w', 496, '2013-06-19', 79, 30.99, 5);
INSERT INTO ksiazka(wydawca_id, seria_id, kategoria_id, autor_id, opis, nazwa, ilosc_stron, data_wydania, ilosc_sztuk, cena_netto, podatek) VALUES (3, 2, 2, 3, 'Na granicach przestrzeni z�odziej, kt�remu pomaga sardoniczny statek, pr�buje si� w�ama� do pude�ka Schr�dingera. Robi to dla swej pracodawczyni oraz dla w�a�cicielki statku Mieli. W pude�ku kryje si� jego wolno��. Albo nie.
Pude�ka strzeg� kody wypaczaj�ce logik� oraz zdrowy rozs�dek. A statek zaatakowano.
Z�odziej jest blisko �mierci, a napastnik po�era statek �ywcem.
Jeanowi de Flambeur zaczyna brakowa� czasu. Wszystkim jego wersjom.
Natomiast na Ziemi dwie siostry w mie�cie Szybkich, kryj�cych si� w cieniu graczy oraz d�inn�w planuj� rewolucj�.
Jest wiele innych historii, kt�re mo�na opowiedzie� w tysi�c i jedn� noc, ale te dwie b�d� si� ��czy�y i splata�y ze sob�, a� rzeczywisto�� przerodzi si� w spiral�.', 'Fraktalny ksi���', 308, '2017-09-30', 35, 36.99, 5);
INSERT INTO ksiazka(wydawca_id, seria_id, kategoria_id, autor_id, opis, nazwa, ilosc_stron, data_wydania, ilosc_sztuk, cena_netto, podatek) VALUES (4, 2, 2, 4, 'Pip Bartlett �yje w �wiecie podobnym do naszego, pe�nym miast, samochod�w czy policji. Zamieszkuj� go r�wnie� magiczne stworzenia, m.in. jednoro�ce, pegazy czy gryfy. Ludzie traktuj� je jak inne zwierz�ta, niekt�re z nich hoduj�, inne uwa�aj� za szkodniki b�d� niebezpieczne stworzenia. Pip jako jedyna potrafi z nimi rozmawia�. Tylko �e nikt z doros�ych w to nie wierzy�', 'Atlas magicznych stworze� Pip Bartlett', 240, '2016-08-31', 88, 12.50, 5);
INSERT INTO ksiazka(wydawca_id, seria_id, kategoria_id, autor_id, opis, nazwa, ilosc_stron, data_wydania, ilosc_sztuk, cena_netto, podatek) VALUES (3, 3, 1, 5, 'Logena Dziewi�ciopalcego, ciesz�cego si� z�� s�aw� barbarzy�c�, opuszcza w ko�cu szcz�cie. Czeka go los martwego barbarzy�cy, kt�ry pozostawi po sobie tylko pie�ni i r�wnie martwych przyjaci�. Jezal dan Luthar, uosobienie egoizmu, �ywi jedno pragnienie: odnie�� zwyci�stwo w kr�gu szermierczym. Lecz zbli�a si� wojna, a na polach bitewnych lodowatej P�nocy walczy si� wed�ug brutalniejszych zasad ni� w turnieju. Inkwizytor Glokta, kaleka, kt�ry sta� si� oprawc�, nie ucieszy�by si� z niczego bardziej ni� z widoku Jezala powracaj�cego do domu w trumnie. Z drugiej strony cz�owiek ten nienawidzi ka�dego. Konieczno�� t�pienia zdrady w sercu Unii, przes�uchanie za przes�uchaniem, nie zyskuje mu przyjaci�, a kolejne zw�oki pozostawiaj� za sob� �lad, kt�ry mo�e doprowadzi� do samego skorumpowanego serca rz�du - je�li Glokta utrzyma si� dostatecznie d�ugo przy �yciu, by owym tropem pod��y�...', 'Ostrze', 702, '2008-12-05', 37, 36.96, 5);
INSERT INTO ksiazka(wydawca_id, seria_id, kategoria_id, autor_id, opis, nazwa, ilosc_stron, data_wydania, ilosc_sztuk, cena_netto, podatek) VALUES (3, 3, 2, 6, 'Gaiman, autor wszechstronny, wyrafinowany i niezr�wnanie tw�rczy, czaruje nas swoj� literack� alchemi� i przenosi daleko w nieznan� krain�, gdzie fantazja staje si� rzeczywisto�ci�, a codzienno�� p�onie w�asnym blaskiem. �Dra�liwe tematy�, pe�ne grozy, niespodzianek i dobrej zabawy, to skarbnica literackich pere�ek, kt�re zajmuj� umys�, poruszaj� serce i wstrz�saj� dusz�.', 'Dra�liwe tematy. Kr�tkie formy i punkty zapalne', 480, '2015-04-22', 4, 40.99, 5);





--table invoice
INSERT INTO faktura(pracownik_id, zamowienie_id, klient_id, data_wystawienia, data_platnosci) VALUES (1, 1, 1, '2020-09-11', '2020-09-21');
INSERT INTO faktura(pracownik_id, zamowienie_id, klient_id, data_wystawienia, data_platnosci) VALUES (2, 2, 2, '2020-11-08', '2000-10-11');
INSERT INTO faktura(pracownik_id, zamowienie_id, klient_id, data_wystawienia, data_platnosci) VALUES (3, 3, 4, '2021-01-25', '2021-02-03');
INSERT INTO faktura(pracownik_id, zamowienie_id, klient_id, data_wystawienia, data_platnosci) VALUES (3, 4, 4, '2021-04-12', '2021-04-28');
INSERT INTO Faktura(pracownik_id, zamowienie_id, klient_id, data_wystawienia, data_platnosci) VALUES (6, 5, 5, '2021-07-05', '2021-07-09');
INSERT INTO faktura(pracownik_id, zamowienie_id, klient_id, data_wystawienia, data_platnosci) VALUES (4, 6, 6, '2021-09-30', '2021-10-07');



--table cart
INSERT INTO koszyk(ksiazka_id, zamowienie_id, cena_netto, podatek, ilosc_sztuk, rabat) VALUES (1, 1, 35.99, 5, 3, 5);
INSERT INTO koszyk(ksiazka_id, zamowienie_id, cena_netto, podatek, ilosc_sztuk, rabat) VALUES (2, 2, 30.99, 5, 1, NULL);
INSERT INTO koszyk(ksiazka_id, zamowienie_id, cena_netto, podatek, ilosc_sztuk, rabat) VALUES (3, 3, 36.99, 5, 2, NULL);
INSERT INTO koszyk(ksiazka_id, zamowienie_id, cena_netto, podatek, ilosc_sztuk, rabat) VALUES (5, 5, 36.96, 5, 10, 15);
INSERT INTO koszyk(ksiazka_id, zamowienie_id, cena_netto, podatek, ilosc_sztuk, rabat) VALUES (6, 6, 40.99, 5, 8, 10);
INSERT INTO koszyk(ksiazka_id, zamowienie_id, cena_netto, podatek, ilosc_sztuk, rabat) VALUES (3, 4, 12.50, 5, 30, 30);



