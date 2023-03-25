ALTER SESSION SET NLS_NUMERIC_CHARACTERS = '.,';
/
CREATE OR REPLACE PACKAGE projektowy IS
FUNCTION generowanie_raportu RETURN CLOB;
FUNCTION generowanie_raportu(data_od DATE, data_do DATE) RETURN CLOB;
FUNCTION calkowity_przychod(data_od DATE, data_do DATE, id_podane INT, kto VARCHAR2)RETURN VARCHAR;
FUNCTION ceny_brutto(v_id koszyk.id%TYPE)RETURN NUMBER;
FUNCTION rekomendacje_ksiazek(v_id klient.id%TYPE) RETURN VARCHAR;
FUNCTION udzial_autora(data_od DATE, data_do DATE, v_id autor.id%TYPE) RETURN NUMBER;

PROCEDURE Dodanie_pracownika_i_adresu(v_imie pracownik.imie%TYPE, v_nazwisko pracownik.nazwisko%TYPE, v_telefon pracownik.telefon%TYPE, v_email pracownik.email%TYPE, v_pesel pracownik.pesel%TYPE, 
                              v_data pracownik.data_zatrudnienia%TYPE, v_pensja pracownik.pensja%TYPE, v_id_a INT, v_kod adres.kod%TYPE, v_numer adres.numer%TYPE, v_ulica adres.ulica%TYPE, v_miejscowosc adres.miejscowosc%TYPE);
PROCEDURE ilosc_ksiazek(v_ksiazka_id koszyk.ksiazka_id%TYPE, v_zamowienie_id koszyk.zamowienie_id%TYPE, v_cena_netto koszyk.cena_netto%TYPE, v_podatek koszyk.podatek%TYPE, 
                                      v_ilosc_sztuk koszyk.ilosc_sztuk%TYPE, v_rabat koszyk.rabat%TYPE);
PROCEDURE popularna_ksiazka(p_id INT, p_procent_znizki NUMBER);
PROCEDURE zamowienie_na_fakture(p_cena_dostawy number, p_data_zamowienia date, p_klient_id int, p_pracownik_id int);
PROCEDURE darmowa_ksiazka;
PROCEDURE darmowa_ksiazka(v_id_ksiazka ksiazka.id%TYPE);

END projektowy;


/




CREATE OR REPLACE PACKAGE BODY projektowy IS

FUNCTION generowanie_raportu RETURN CLOB
AS
v_raport CLOB;
BEGIN
    --Wyswietlenie ilosci zamowien
    SELECT 'Ilosc zamowien: ' || COUNT(id) INTO v_raport FROM zamowienie;

    --wyswietlenie liczbe klientow
    SELECT v_raport ||
    ' Liczba klientów: ' || COUNT(*)
    INTO v_raport FROM klient; 
    
    --Wyswietlenie najlepiej sprzedajacej sie ksiazki
    SELECT 
    v_raport || 
    ' Najlepiej sprzedajaca sie ksiazka: ' ||
     nazwa 
    INTO v_raport
    FROM 
    ( SELECT ks.nazwa, k.ilosc_sztuk FROM
    koszyk k JOIN ksiazka ks ON k.ksiazka_id = ks.id
    JOIN  zamowienie z ON k.zamowienie_id = z.id
    GROUP BY ks.nazwa, k.ilosc_sztuk
    ORDER BY SUM(ilosc_sztuk) DESC
    )
    WHERE ROWNUM = 1;
    
    RETURN v_raport;
END;


FUNCTION generowanie_raportu(data_od DATE, data_do DATE) RETURN CLOB
AS
v_raport CLOB;
BEGIN
    --Wyswietlenie ilosci zamowien
    SELECT 'Ilosc zamowien: ' || COUNT(id) INTO v_raport FROM zamowienie
    WHERE data_zamowienia BETWEEN data_od AND data_do;

    --wyswietlenie liczbe klientow
    SELECT v_raport ||
    ' Liczba klientów: ' || COUNT(*)
    INTO v_raport FROM klient; 
    
    --Wyswietlenie najlepiej sprzedajacej sie ksiazki
    SELECT 
    v_raport || 
    ' Najlepiej sprzedajaca sie ksiazka: ' ||
     nazwa 
    INTO v_raport
    FROM 
    ( SELECT ks.nazwa, k.ilosc_sztuk FROM
    koszyk k JOIN ksiazka ks ON k.ksiazka_id = ks.id
    JOIN  zamowienie z ON k.zamowienie_id = z.id
    WHERE data_zamowienia BETWEEN data_od AND data_do
    GROUP BY ks.nazwa, k.ilosc_sztuk
    ORDER BY SUM(ilosc_sztuk) DESC
    )
    WHERE ROWNUM = 1;
    
    RETURN v_raport;
END;



FUNCTION calkowity_przychod(data_od DATE, data_do DATE, id_podane INT, kto VARCHAR2)
RETURN VARCHAR AS
v_przychod VARCHAR(100);
BEGIN
    IF kto = 'autor' THEN
        SELECT SUM(ko.cena_netto*ko.ilosc_sztuk)
        INTO v_przychod
        FROM autor a JOIN ksiazka k ON a.id = k.autor_id
        JOIN koszyk ko ON k.id = ko.ksiazka_id
        JOIN zamowienie z ON ko.zamowienie_id = z.id
        WHERE z.data_zamowienia BETWEEN data_od AND data_do AND k.autor_id = id_podane;
    ELSIF kto = 'wydawca' THEN
        SELECT SUM(ko.cena_netto*ko.ilosc_sztuk)
        INTO v_przychod
        FROM wydawca w JOIN ksiazka k ON w.id = k.wydawca_id
        JOIN koszyk ko ON k.id = ko.ksiazka_id
        JOIN zamowienie z ON ko.zamowienie_id = z.id
        WHERE z.data_zamowienia BETWEEN data_od AND data_do AND k.wydawca_id = id_podane;
    ELSE
        v_przychod := 'NIEPOPRAWNA NAZWA';
    END IF;
    
    RETURN v_przychod;
END;

FUNCTION ceny_brutto(v_id koszyk.id%TYPE)
RETURN NUMBER IS
v_cena NUMBER;
v_cena_netto koszyk.cena_netto%type;
v_podatek koszyk.podatek%type;
v_rabat koszyk.rabat%type;
v_ilosc_sztuk koszyk.ilosc_sztuk%type;
v_cena2 NUMBER;
v_cena_dostawy zamowienie.cena_dostawy%type;
v_zamowienie INT;
BEGIN 
    SELECT cena_netto INTO v_cena_netto FROM koszyk WHERE id = v_id;
    SELECT podatek INTO v_podatek FROM koszyk WHERE id = v_id;
    SELECT rabat INTO v_rabat FROM koszyk WHERE id = v_id;
    SELECT ilosc_sztuk INTO v_ilosc_sztuk FROM koszyk WHERE id =v_id;
    IF v_rabat > 0 THEN
        v_cena := ((v_cena_netto + ((v_podatek*v_cena_netto)/100) - ((v_rabat*v_cena_netto)/100)) * v_ilosc_sztuk);
    ELSE
        v_cena := ((v_cena_netto + ((v_podatek*v_cena_netto)/100)) * v_ilosc_sztuk);
    END IF;
    
    IF v_cena_dostawy >0 THEN
        SELECT zamowienie_id INTO v_zamowienie FROM koszyk WHERE id = v_id;
        SELECT cena_dostawy INTO v_cena_dostawy FROM zamowienie WHERE id = v_zamowienie;
        v_cena2 := v_cena + v_cena_dostawy;
        RETURN v_cena2;
    ELSE
        RETURN v_cena;
    END IF;
END;



FUNCTION rekomendacje_ksiazek(v_id klient.id%TYPE) RETURN VARCHAR
AS
v_rekomendacje VARCHAR(100);
BEGIN

    SELECT distinct ks.nazwa INTO v_rekomendacje
    FROM ksiazka ks
    JOIN koszyk ko ON ks.id = ko.ksiazka_id
    JOIN zamowienie z ON ko.zamowienie_id = z.id
    JOIN klient k ON z.klient_id = k.id
    WHERE ks.id NOT IN (
    SELECT ks1.id
    FROM ksiazka ks1
    JOIN koszyk ko1 ON ks1.id = ko1.ksiazka_id
    JOIN zamowienie z1 ON ko1.zamowienie_id = z1.id
    JOIN klient k1 ON z1.klient_id = k1.id
    WHERE k1.id = v_id
    )
    AND k.id IN (
    SELECT DISTINCT k2.id
    FROM ksiazka ks2
    JOIN koszyk ko2 ON ks2.id = ko2.ksiazka_id
    JOIN zamowienie z2 ON ko2.zamowienie_id = z2.id
    JOIN klient k2 ON z2.klient_id = k2.id
    WHERE k2.id != v_id
    AND ks2.id IN (
    SELECT ks3.id
    FROM ksiazka ks3
    JOIN koszyk ko3 ON ks3.id = ko3.ksiazka_id
    JOIN zamowienie z3 ON ko3.zamowienie_id = z3.id
    JOIN klient k3 ON z3.klient_id = k3.id
    WHERE k3.id = v_id
    )
    ) AND ROWNUM = 1;

    RETURN v_rekomendacje;
END;



FUNCTION udzial_autora(data_od DATE, data_do DATE, v_id autor.id%TYPE) RETURN NUMBER
AS
v_suma NUMBER;
v_udzial NUMBER;
BEGIN

    SELECT SUM(k.cena_netto * k.ilosc_sztuk)
    INTO v_suma
    FROM koszyk k JOIN ksiazka ks ON k.ksiazka_id = ks.id
    JOIN zamowienie z ON k.zamowienie_id = z.id
    WHERE data_zamowienia BETWEEN data_od AND data_do;
    
    SELECT SUM(k.cena_netto*k.ilosc_sztuk)
    INTO v_udzial
    FROM koszyk k JOIN ksiazka ks ON k.ksiazka_id = ks.id
    JOIN zamowienie z ON k.zamowienie_id = z.id
    WHERE data_zamowienia BETWEEN data_od AND data_do AND autor_id = v_id;
    
    RETURN ROUND(v_udzial/v_suma * 100, 2);
END;



PROCEDURE Dodanie_pracownika_i_adresu(v_imie pracownik.imie%TYPE, v_nazwisko pracownik.nazwisko%TYPE, v_telefon pracownik.telefon%TYPE, v_email pracownik.email%TYPE, v_pesel pracownik.pesel%TYPE, 
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



PROCEDURE ilosc_ksiazek(v_ksiazka_id koszyk.ksiazka_id%TYPE, v_zamowienie_id koszyk.zamowienie_id%TYPE, v_cena_netto koszyk.cena_netto%TYPE, v_podatek koszyk.podatek%TYPE, 
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
        RAISE_APPLICATION_ERROR(-20000, 'Nie ma podanej ksiazki');
    ELSE
        SELECT ilosc_sztuk INTO licz FROM ksiazka WHERE id = v_ksiazka_id;
    END IF;
    IF v_ilosc_sztuk > licz THEN
        DBMS_OUTPUT.PUT_LINE('Nie mozna dodac ksiazki do koszyka, poniewaz wybrano zbyt duza ilosc sztuk');
    ELSE
        INSERT INTO koszyk(ksiazka_id, zamowienie_id, cena_netto, podatek, ilosc_sztuk, rabat) VALUES (v_ksiazka_id, v_zamowienie_id, v_cena_netto, v_podatek, v_ilosc_sztuk, v_rabat);
        UPDATE ksiazka SET ilosc_sztuk = ilosc_sztuk - v_ilosc_sztuk WHERE id = v_ksiazka_id; 
    END IF;
END;


  
PROCEDURE popularna_ksiazka(p_id INT, p_procent_znizki NUMBER) IS
v_zmienna NUMBER;
v_ilosc int;
begin
     SELECT COUNT(*) INTO v_zmienna
     FROM (SELECT ksiazka_id, SUM(ilosc_sztuk) FROM koszyk 
     WHERE ksiazka_id=p_id GROUP BY ksiazka_id HAVING SUM(ilosc_sztuk)>10);
     IF( v_zmienna = 0) THEN
        dbms_output.put_line('Nie można zmienic ceny. Ksiazka nie spełnia warunków.');
     ELSE
        SELECT SUM(ilosc_sztuk) INTO v_ilosc FROM koszyk 
        WHERE ksiazka_id=p_id HAVING SUM(ilosc_sztuk)>10;
        dbms_output.put_line('Ilosc zamowien ksiazki: ' || v_ilosc);
        UPDATE ksiazka SET cena_netto=cena_netto*(1-p_procent_znizki/100) WHERE id=p_id;
        UPDATE koszyk SET cena_netto=cena_netto*(1-p_procent_znizki/100) WHERE ksiazka_id=p_id;
     END IF;
END;



PROCEDURE zamowienie_na_fakture(p_cena_dostawy NUMBER, p_data_zamowienia DATE, 
p_klient_id INT, p_pracownik_id INT) IS
v_id INT;
BEGIN
    INSERT INTO zamowienie(klient_id, pracownik_id, cena_dostawy, data_zamowienia) 
    VALUES (p_klient_id, p_pracownik_id, p_cena_dostawy, p_data_zamowienia);
    SELECT id INTO v_id FROM zamowienie WHERE id = (SELECT MAX(id) FROM zamowienie);
    dbms_output.put_line('Utworzono zamowienie o ID: ' || v_id);
    INSERT INTO faktura(pracownik_id, zamowienie_id, klient_id, data_wystawienia, data_platnosci) 
    VALUES (p_pracownik_id, v_id, p_klient_id, p_data_zamowienia, p_data_zamowienia);
    SELECT id INTO v_id FROM faktura WHERE id = (SELECT max(id) FROM faktura);
    dbms_output.put_line('Utworzono fakture o ID: ' || v_id);
END;



PROCEDURE darmowa_ksiazka IS
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
    dbms_output.put_line('Wylosowano ksiazke o id: ' || v_wylosowane_id_ksiazki || ' o tytule ' ||v_tytul_wylosowanej_ksiazki );
    INSERT INTO zamowienie(cena_dostawy,data_zamowienia,klient_id,pracownik_id) 
    VALUES(0,sysdate,v_wylosowane_id_klienta,v_wylosowane_id_klienta);
    SELECT id INTO v_id_zamowienie FROM zamowienie WHERE id = (SELECT MAX(id) FROM zamowienie);
    INSERT INTO koszyk(cena_netto,podatek,ilosc_sztuk,rabat,ksiazka_id,zamowienie_id) 
    VALUES(0,0,1,0,v_wylosowane_id_ksiazki,v_id_zamowienie);
END;



PROCEDURE darmowa_ksiazka(v_id_ksiazka ksiazka.id%TYPE) IS
v_max_id_klienta INT;
v_wylosowane_id_klienta INT;
v_wylosowane_id_ksiazki INT;
v_tytul_wylosowanej_ksiazki VARCHAR2(70);
v_id_zamowienie INT;
BEGIN
    SELECT id INTO v_max_id_klienta FROM klient WHERE id = (SELECT MAX(id) FROM klient);
    SELECT floor(dbms_random.value(1,v_max_id_klienta)) num INTO v_wylosowane_id_klienta  from dual;
    dbms_output.put_line('Wylosowano klienta o id: ' || v_wylosowane_id_klienta);
    SELECT nazwa INTO v_tytul_wylosowanej_ksiazki FROM ksiazka WHERE id =v_id_ksiazka;
    dbms_output.put_line('Dostaje ksiazke o id: ' || v_id_ksiazka || ' o tytule ' ||v_tytul_wylosowanej_ksiazki );
    INSERT INTO zamowienie(cena_dostawy,data_zamowienia,klient_id,pracownik_id) 
    values(0,sysdate,v_wylosowane_id_klienta,v_wylosowane_id_klienta);
    SELECT id INTO v_id_zamowienie FROM zamowienie WHERE id = (SELECT MAX(id) FROM zamowienie);
    INSERT INTO koszyk(cena_netto,podatek,ilosc_sztuk,rabat,ksiazka_id,zamowienie_id) 
    values(0,0,1,0,v_id_ksiazka,v_id_zamowienie);
END;


END projektowy;

/


EXEC projektowy.darmowa_ksiazka;
/
EXEC projektowy.darmowa_ksiazka(2);
/
SELECT projektowy.generowanie_raportu(TO_DATE('2020-10-08', 'YYYY-MM-DD'),  TO_DATE('2021-09-01', 'YYYY-MM-DD')) FROM DUAL;
/
SELECT projektowy.generowanie_raportu FROM DUAL;