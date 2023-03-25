--1. The procedure for adding a new employee and a new address, if it does not exist yet

CREATE OR REPLACE PROCEDURE Dodanie_pracownika_i_adresu(v_imie pracownik.imie%TYPE, v_nazwisko pracownik.nazwisko%TYPE, v_telefon pracownik.telefon%TYPE, v_email pracownik.email%TYPE, v_pesel pracownik.pesel%TYPE, 
                              v_data pracownik.data_zatrudnienia%TYPE, v_pensja pracownik.pensja%TYPE, v_id_a INT, v_kod adres.kod%TYPE, v_numer adres.numer%TYPE, v_ulica adres.ulica%TYPE, v_miejscowosc adres.miejscowosc%TYPE)
IS
licz INT;
v_id INT;
BEGIN
    SELECT COUNT(*) INTO licz FROM adres
    WHERE (adres.kod = v_kod AND adres.numer = v_numer AND adres.ulica = v_ulica AND adres.miejscowosc = v_miejscowosc);
    IF licz = 0  THEN
        INSERT INTO adres(id, kod, numer, ulica, miejscowosc) values(v_id_a, v_kod, v_numer, v_ulica, v_miejscowosc);
        INSERT INTO pracownik( adres_id, imie, nazwisko, telefon, email, pesel, data_zatrudnienia, pensja) values (v_id_a, v_imie, v_nazwisko, v_telefon, v_email, v_pesel, v_data, v_pensja);
    ELSE
        SELECT id INTO v_id FROM adres WHERE kod = v_kod AND numer = v_numer AND ulica = v_ulica AND miejscowosc = v_miejscowosc;
        INSERT INTO pracownik( adres_id, imie, nazwisko, telefon, email, pesel, data_zatrudnienia, pensja) values (v_id, v_imie, v_nazwisko, v_telefon, v_email, v_pesel, v_data, v_pensja);
    END IF;
END;

/
-- Adding an employee with an existing address
EXEC Dodanie_pracownika_i_adresu('Agata2', 'Nowak2', '123775951', 'Aga77@gmail.com', '0090744556', '2016-01-21', 5000, 22, '80-690', '87/1', 'Frezjowa', 'Gdansk');
/
--Adding an employee with a new address
EXEC Dodanie_pracownika_i_adresu('Agata2', 'Nowak2', '223775951', 'Aga70@gmail.com', '0390744556', '2016-01-21', 5000, 22, '80-690', '87/1', 'Frezjowa', 'Gdansk2');

/
SELECT * FROM pracownik;
SELECT * FROM adres;




--2. A procedure that, after adding a book to the cart, reduces the number of books

CREATE OR REPLACE PROCEDURE ilosc_ksiazek(v_ksiazka_id koszyk.ksiazka_id%TYPE, v_zamowienie_id koszyk.zamowienie_id%TYPE, v_cena_netto koszyk.cena_netto%TYPE, v_podatek koszyk.podatek%TYPE, 
                                      v_ilosc_sztuk koszyk.ilosc_sztuk%TYPE, v_rabat koszyk.rabat%TYPE)                            
IS
v_id INT;
licz INT;
ilosc INT;
ilosc2 INT;
zmienna ksiazka%ROWTYPE;
BEGIN
    SELECT COUNT(*) INTO ilosc FROM ksiazka where id=v_ksiazka_id;
    SELECT COUNT(*) INTO ilosc2 FROM koszyk WHERE zamowienie_id = v_zamowienie_id;
    IF ilosc = 0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'There is no book listed');
    ELSE
        SELECT ilosc_sztuk INTO licz FROM ksiazka WHERE id = v_ksiazka_id;
    END IF;
    IF v_ilosc_sztuk > licz THEN
        DBMS_OUTPUT.PUT_LINE('The book could not be added to the cart because too many items were selected');
    ELSE
        INSERT INTO koszyk(ksiazka_id, zamowienie_id, cena_netto, podatek, ilosc_sztuk, rabat) VALUES (v_ksiazka_id, v_zamowienie_id, v_cena_netto, v_podatek, v_ilosc_sztuk, v_rabat);
        UPDATE ksiazka SET ilosc_sztuk = ilosc_sztuk - v_ilosc_sztuk WHERE id = v_ksiazka_id; 
    END IF;
END;

/
EXEC ilosc_ksiazek(3, 5, 33, 4, 22, 8);

/
SELECT * FROM ksiazka;
SELECT * FROM koszyk;
SELECT * FROM zamowienie;






--3. if the book is popular (it has been ordered a certain number of times, e.g. 10)
--it decreases its price (in the book and in the cart)

CREATE OR REPLACE PROCEDURE popularna_ksiazka(p_id INT, p_procent_znizki NUMBER) IS
v_zmienna NUMBER;
v_ilosc int;
begin
     SELECT COUNT(*) INTO v_zmienna
     FROM (SELECT ksiazka_id, SUM(ilosc_sztuk) FROM koszyk 
     WHERE ksiazka_id=p_id GROUP BY ksiazka_id HAVING SUM(ilosc_sztuk)>5);
     IF( v_zmienna = 0) THEN
        dbms_output.put_line('Price cannot be changed. The book does not meet the conditions.');
     ELSE
        SELECT SUM(ilosc_sztuk) INTO v_ilosc FROM koszyk 
        WHERE ksiazka_id=p_id HAVING SUM(ilosc_sztuk)>5;
        dbms_output.put_line('Number of book orders: ' || v_ilosc);
        UPDATE ksiazka SET cena_netto=cena_netto*(1-p_procent_znizki/100) WHERE id=p_id;
        UPDATE koszyk SET cena_netto=cena_netto*(1-p_procent_znizki/100) WHERE ksiazka_id=p_id;
     END IF;
END;
/
EXEC popularna_ksiazka(3, 10)
/
SELECT * FROM klient;
SELECT * FROM koszyk;
SELECT * FROM zamowienie;
/
INSERT INTO zamowienie(klient_id, pracownik_id, cena_dostawy, data_zamowienia) VALUES (5, 6, 3.99, '2020-08-01');






--4. we add an order and immediately generate an invoice

ALTER SESSION SET NLS_NUMERIC_CHARACTERS = '.,';

/
CREATE OR REPLACE PROCEDURE zamowienie_na_fakture(p_cena_dostawy NUMBER, p_data_zamowienia DATE, 
p_klient_id INT, p_pracownik_id INT) IS
v_id INT;
BEGIN
    INSERT INTO zamowienie(klient_id, pracownik_id, cena_dostawy, data_zamowienia) 
    VALUES (p_klient_id, p_pracownik_id, p_cena_dostawy, p_data_zamowienia);
    SELECT id INTO v_id FROM zamowienie WHERE id = (SELECT MAX(id) FROM zamowienie);
    dbms_output.put_line('Order created with ID: ' || v_id);
    INSERT INTO faktura(pracownik_id, zamowienie_id, klient_id, data_wystawienia, data_platnosci) 
    VALUES (p_pracownik_id, v_id, p_klient_id, p_data_zamowienia, p_data_zamowienia);
    SELECT id INTO v_id FROM faktura WHERE id = (SELECT max(id) FROM faktura);
    dbms_output.put_line('Invoice created with ID: ' || v_id);
END;

/
EXEC zamowienie_na_fakture(12.22, sysdate, 2, 4);
/
SELECT * FROM faktura;
SELECT * FROM zamowienie;





--5. draw a customer who will get a free book and put it in his cart
    

CREATE OR REPLACE PROCEDURE darmowa_ksiazka IS
v_max_id_klienta INT;
v_max_id_ksiazki INT;
v_wylosowane_id_klienta INT;
v_wylosowane_id_ksiazki INT;
v_tytul_wylosowanej_ksiazki VARCHAR2(70);
v_id_zamowienie INT;
BEGIN
    SELECT id INTO v_max_id_klienta FROM klient WHERE id = (SELECT MAX(id) FROM klient);
    SELECT floor(dbms_random.value(1,v_max_id_klienta)) num into v_wylosowane_id_klienta  from dual;
    dbms_output.put_line('Wylosowano klienta o id: ' || v_wylosowane_id_klienta);
    SELECT id INTO v_max_id_ksiazki FROM klient WHERE id = (SELECT MAX(id) FROM ksiazka);
    SELECT floor(dbms_random.value(1,v_max_id_ksiazki)) num INTO v_wylosowane_id_ksiazki  from dual;
    SELECT nazwa INTO v_tytul_wylosowanej_ksiazki from ksiazka where id=v_wylosowane_id_ksiazki;
    dbms_output.put_line('A book was drawn with id: ' || v_wylosowane_id_ksiazki || ' about the title ' ||v_tytul_wylosowanej_ksiazki );
    INSERT INTO zamowienie(cena_dostawy,data_zamowienia,klient_id,pracownik_id) 
    VALUES(0,sysdate,v_wylosowane_id_klienta,v_wylosowane_id_klienta);
    SELECT id INTO v_id_zamowienie FROM zamowienie WHERE id = (SELECT MAX(id) FROM zamowienie);
    INSERT INTO koszyk(cena_netto,podatek,ilosc_sztuk,rabat,ksiazka_id,zamowienie_id) 
    VALUES(0,0,1,0,v_wylosowane_id_ksiazki,v_id_zamowienie);
END;


/
EXEC darmowa_ksiazka;