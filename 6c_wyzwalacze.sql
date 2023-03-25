--1. trigger that adds a new order if a new id appears when adding to the cart

  CREATE OR REPLACE TRIGGER dodaj_zamowienie BEFORE INSERT OR UPDATE ON koszyk FOR EACH ROW
  DECLARE
  licz INT;
  BEGIN
  SELECT COUNT(*) INTO licz FROM zamowienie WHERE id = :new.zamowienie_id;
    IF INSERTING AND licz = 0 THEN
    INSERT INTO zamowienie(id, klient_id, pracownik_id, cena_dostawy, data_zamowienia) VALUES (:new.zamowienie_id, 1, 6, 10.99, sysdate);
    ELSIF UPDATING AND licz = 0 THEN
    INSERT INTO zamowienie(id, klient_id, pracownik_id, cena_dostawy, data_zamowienia) VALUES (:new.zamowienie_id, 1, 6, 10.99, sysdate);
    END IF;
    END;
/
SELECT * FROM ZAMOWIENIE;
SELECT * FROM KOSZYK;
/
INSERT INTO koszyk(ksiazka_id, zamowienie_id, cena_netto, podatek, ilosc_sztuk, rabat) VALUES (6, 100, 40.99, 5, 8, 10);




--2. trigger that archives a book when it is deleted and removes it from the cart if it is there
CREATE TABLE archiwum_ksiazek(id INT, nazwa VARCHAR2(70), data_zmiany DATE)
 /
CREATE OR REPLACE TRIGGER usuwanie_ksiazek BEFORE DELETE ON ksiazka FOR EACH ROW
    BEGIN
    IF DELETING THEN
        INSERT INTO archiwum_ksiazek(id, nazwa, data_zmiany) VALUES (:old.id, :old.nazwa, sysdate);
        DELETE FROM koszyk WHERE ksiazka_id = :old.id;
    END IF;
END;
    /
DELETE FROM ksiazka WHERE id = 6;
/
SELECT * FROM ksiazka;
SELECT * FROM archiwum_ksiazek;
SELECT * FROM koszyk;





--3.changing the price of a book also changes the price in the cart, but you cannot set the price of the book
 ==less than 10 zlotys.

CREATE OR REPLACE TRIGGER zmiana_ceny BEFORE UPDATE ON ksiazka FOR EACH ROW
DECLARE
BEGIN
  IF UPDATING THEN
   IF (:new.cena_netto>=10) THEN
        UPDATE koszyk SET cena_netto = :new.cena_netto WHERE ksiazka_id = :old.id;
    ELSE
        RAISE_APPLICATION_ERROR(-20500, 'You cannot set a price below ten zlotys');
        ROLLBACK;
  END IF;
  END IF;
END;

/
UPDATE ksiazka SET cena_netto = 39.99 WHERE id = 2;
/
SELECT * FROM ksiazka;








--4. if we remove an employee, we archive him, and if no one else has such an address, we also delete address and also archive

CREATE TABLE archiwum_pracownikow(id INT, imie VARCHAR2(30), nazwisko VARCHAR2(30), data_zmiany DATE);
/
CREATE TABLE archiwum_adresow(id INT, kod  CHAR(9), numer CHAR(5), ulica CHAR(30), miejscowosc VARCHAR2(30), data_zmiany DATE);
/
ALTER TABLE pracownik ADD usuniety INT;
/
ALTER TABLE adres ADD usuniety INT;
/
CREATE OR REPLACE VIEW pomocny_widok AS SELECT * FROM pracownik;
/
  CREATE OR REPLACE TRIGGER adres_pracownika INSTEAD OF DELETE ON pomocny_widok FOR EACH ROW
  DECLARE
  licz INT;
  licz2 INT;
  suma INT;
  v_kod adres.kod%TYPE;
  v_numer adres.numer%TYPE;
  v_ulica adres.ulica%TYPE;
  v_miejscowosc adres.miejscowosc%TYPE;
  BEGIN  
    IF DELETING THEN
        UPDATE pracownik SET usuniety = 1 WHERE id = :old.id;
        INSERT INTO archiwum_pracownikow(id, imie, nazwisko, data_zmiany) VALUES (:old.id, :old.imie, :old.nazwisko, sysdate);
    END IF;
    SELECT COUNT(*) INTO licz FROM pracownik WHERE adres_id = :old.adres_id;
    SELECT COUNT(*) INTO licz2 FROM klient WHERE adres_id = :old.adres_id;
    suma := (licz-1) + licz2;   
    IF (suma = 0) THEN
        SELECT kod, numer, ulica, miejscowosc INTO v_kod, v_numer, v_ulica, v_miejscowosc FROM adres WHERE id = :old.adres_id;
        UPDATE adres SET usuniety = 1 WHERE id = :old.adres_id;
        INSERT INTO archiwum_adresow(id, kod, numer, ulica, miejscowosc, data_zmiany) VALUES (:old.adres_id, v_kod, v_numer, v_ulica, v_miejscowosc, sysdate);
    END IF;
  END;
  /
DELETE FROM pomocny_widok WHERE id = 3;
/

SELECT * FROM archiwum_pracownikow;
SELECT * FROM archiwum_adresow;
SELECT * FROM pracownik;
SELECT * FROM klient;
select * from adres;





--5.trigger to ban deleting orders if they are less than 4 years old
CREATE OR REPLACE TRIGGER  stare_zamowienie BEFORE DELETE ON zamowienie FOR EACH ROW
DECLARE
v_years INT;
v_data_usuwana DATE;
BEGIN
    v_data_usuwana:=:old.data_zamowienia;
    SELECT floor(months_between(sysdate, v_data_usuwana) /12) INTO v_years FROM dual;
    IF (v_years<4) THEN
        RAISE_APPLICATION_ERROR(-20500, 'Orders less than 4 years old cannot be deleted');
        ROLLBACK;
    END IF;
END;
/
SELECT * FROM ZAMOWIENIE;
/
DELETE zamowienie WHERE id = 4;