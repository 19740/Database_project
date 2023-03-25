
--table addresss, columns: id, code, number, street, town
CREATE TABLE adres (
    id          INTEGER NOT NULL,
    kod         CHAR(9) NOT NULL,
    numer       CHAR(5) NOT NULL,
    ulica       CHAR(30) NOT NULL,
    miejscowosc VARCHAR2(30) NOT NULL
);

COMMENT ON TABLE adres IS
    'Adres';

ALTER TABLE adres ADD CONSTRAINT adres_pk PRIMARY KEY ( id );


--table author, columns: id, name, surname
CREATE TABLE autor (
    id       INTEGER NOT NULL,
    imie     VARCHAR2(30) NOT NULL,
    nazwisko VARCHAR2(30) NOT NULL
);

COMMENT ON TABLE autor IS
    'Autor';

ALTER TABLE autor ADD CONSTRAINT autor_pk PRIMARY KEY ( id );


--table invoice, columns id, invoice date, payment date, customer_id, order_id, employee_id
CREATE TABLE faktura (
    id               INTEGER NOT NULL,
    data_wystawienia DATE NOT NULL,
    data_platnosci   DATE NOT NULL,
    klient_id        INTEGER NOT NULL,
    zamowienie_id    INTEGER NOT NULL,
    pracownik_id     INTEGER NOT NULL
);

COMMENT ON TABLE faktura IS
    'Faktura';

ALTER TABLE faktura ADD CONSTRAINT faktura_pk PRIMARY KEY ( id );


--table category, columns id, name
CREATE TABLE kategoria (
    id    INTEGER NOT NULL,
    nazwa VARCHAR2(20)
);

COMMENT ON TABLE kategoria IS
    'Kategoria';

ALTER TABLE kategoria ADD CONSTRAINT kategoria_pk PRIMARY KEY ( id );

ALTER TABLE kategoria ADD CONSTRAINT kategoria__un UNIQUE ( nazwa );


--table customer, columns: id, name, surname, telephone, email, password, address_id
CREATE TABLE klient (
    id       INTEGER NOT NULL,
    imie     VARCHAR2(30) NOT NULL,
    nazwisko VARCHAR2(30) NOT NULL,
    telefon  INTEGER NOT NULL,
    email    VARCHAR2(30) NOT NULL,
    haslo    VARCHAR2(30) NOT NULL CHECK (LENGTH(haslo) > 5),
    adres_id INTEGER NOT NULL
);

COMMENT ON TABLE klient IS
    'Klient';

ALTER TABLE klient ADD CONSTRAINT klient_pk PRIMARY KEY ( id );

ALTER TABLE klient ADD CONSTRAINT klient__un UNIQUE ( telefon,
                                                      email );

--table cart, columns: id, net price, tax, quantity, discount, book_id, order_id
CREATE TABLE koszyk (
    id            INTEGER NOT NULL,
    cena_netto    NUMBER NOT NULL,
    podatek       INTEGER DEFAULT 5,
    ilosc_sztuk   INTEGER NOT NULL CHECK (ilosc_sztuk>0),
    rabat         INTEGER DEFAULT 0,
    ksiazka_id    INTEGER NOT NULL,
    zamowienie_id INTEGER NOT NULL
);


COMMENT ON TABLE koszyk IS
    'Koszyk';

ALTER TABLE koszyk ADD CONSTRAINT koszyk_pk PRIMARY KEY ( id );


--table book, columns: id, description, title, number of pages, publication date, number of copies, net price, tax, publisher_id, series_id, 
//category_id, author_id
CREATE TABLE ksiazka (
    id           INTEGER NOT NULL,
    opis         VARCHAR2(1100) NOT NULL,
    nazwa        VARCHAR2(70) NOT NULL,
    ilosc_stron  INTEGER NOT NULL,
    data_wydania DATE NOT NULL,
    ilosc_sztuk  INTEGER NOT NULL CHECK (ilosc_sztuk>0),
    cena_netto   NUMBER NOT NULL,
    podatek      INTEGER DEFAULT 5,
    wydawca_id   INTEGER NOT NULL,
    seria_id     INTEGER NOT NULL,
    kategoria_id INTEGER NOT NULL,
    autor_id     INTEGER NOT NULL
);

COMMENT ON TABLE ksiazka IS
    'Ksiazka';

CREATE INDEX ksiazka__idx ON
    ksiazka (
        nazwa
    ASC );

ALTER TABLE ksiazka ADD CONSTRAINT ksiazka_pk PRIMARY KEY ( id );


--table employee, columns: id, name, surname, telephone, email, PESEL, date of employment, salary, address_id
CREATE TABLE pracownik (
    id                INTEGER NOT NULL,
    imie              VARCHAR2(30) NOT NULL,
    nazwisko          VARCHAR2(30) NOT NULL,
    telefon           INTEGER NOT NULL,
    email             VARCHAR2(40) NOT NULL,
    pesel             CHAR(11) NOT NULL,
    data_zatrudnienia DATE NOT NULL,
    pensja            INTEGER NOT NULL,
    adres_id          INTEGER NOT NULL
);

COMMENT ON TABLE pracownik IS
    'Pracownik';

ALTER TABLE pracownik ADD CONSTRAINT pracownik_pk PRIMARY KEY ( id );

ALTER TABLE pracownik
    ADD CONSTRAINT pracownik__un UNIQUE ( telefon,
                                          email,
                                          pesel );

--table series, columns: id, name, number of volumes
CREATE TABLE seria (
    id          INTEGER NOT NULL,
    nazwa       VARCHAR2(30) NOT NULL,
    ilosc_tomow INTEGER NOT NULL CHECK (ilosc_tomow>1)
);

COMMENT ON TABLE seria IS
    'Seria';

ALTER TABLE seria ADD CONSTRAINT seria_pk PRIMARY KEY ( id );


--table status, columns: id, name, description
CREATE TABLE stan (
    id    INTEGER NOT NULL,
    nazwa VARCHAR2(40) NOT NULL,
    opis  VARCHAR2(150)
);

COMMENT ON TABLE stan IS
    'Stan';

ALTER TABLE stan ADD CONSTRAINT stan_pk PRIMARY KEY ( id );

--table status of the order, columns: id, date of change, status_id, order_id
CREATE TABLE stan_zamowienia (
    id            INTEGER NOT NULL,
    data_zmiany   DATE NOT NULL,
    stan_id       INTEGER NOT NULL,
    zamowienie_id INTEGER NOT NULL
);

COMMENT ON TABLE stan_zamowienia IS
    'Stan_zamowienia';

ALTER TABLE stan_zamowienia ADD CONSTRAINT stan_zamowienia_pk PRIMARY KEY ( id );

--table publisher, columns: id, name
CREATE TABLE wydawca (
    id    INTEGER NOT NULL,
    nazwa VARCHAR2(20) NOT NULL
);

COMMENT ON TABLE wydawca IS
    'Wydawca';

ALTER TABLE wydawca ADD CONSTRAINT wydawca_pk PRIMARY KEY ( id );

ALTER TABLE wydawca ADD CONSTRAINT wydawca__un UNIQUE ( nazwa );

--table order, columns: id, delivery price, date of order, customer_id, employee_id
CREATE TABLE zamowienie (
    id              INTEGER NOT NULL,
    cena_dostawy    NUMBER DEFAULT 0,
    data_zamowienia DATE NOT NULL,
    klient_id       INTEGER NOT NULL,
    pracownik_id    INTEGER NOT NULL
);

COMMENT ON TABLE zamowienie IS
    'Zamowienie';

ALTER TABLE zamowienie ADD CONSTRAINT zamowienie_pk PRIMARY KEY ( id );

ALTER TABLE faktura
    ADD CONSTRAINT faktura_klient_fk FOREIGN KEY ( klient_id )
        REFERENCES klient ( id );

ALTER TABLE faktura
    ADD CONSTRAINT faktura_pracownik_fk FOREIGN KEY ( pracownik_id )
        REFERENCES pracownik ( id );

ALTER TABLE faktura
    ADD CONSTRAINT faktura_zamowienie_fk FOREIGN KEY ( zamowienie_id )
        REFERENCES zamowienie ( id );

ALTER TABLE klient
    ADD CONSTRAINT klient_adres_fk FOREIGN KEY ( adres_id )
        REFERENCES adres ( id );

ALTER TABLE koszyk
    ADD CONSTRAINT koszyk_ksiazka_fk FOREIGN KEY ( ksiazka_id )
        REFERENCES ksiazka ( id );

ALTER TABLE koszyk
    ADD CONSTRAINT koszyk_zamowienie_fk FOREIGN KEY ( zamowienie_id )
        REFERENCES zamowienie ( id );

ALTER TABLE ksiazka
    ADD CONSTRAINT ksiazka_autor_fk FOREIGN KEY ( autor_id )
        REFERENCES autor ( id );

ALTER TABLE ksiazka
    ADD CONSTRAINT ksiazka_kategoria_fk FOREIGN KEY ( kategoria_id )
        REFERENCES kategoria ( id );

ALTER TABLE ksiazka
    ADD CONSTRAINT ksiazka_seria_fk FOREIGN KEY ( seria_id )
        REFERENCES seria ( id );

ALTER TABLE ksiazka
    ADD CONSTRAINT ksiazka_wydawca_fk FOREIGN KEY ( wydawca_id )
        REFERENCES wydawca ( id );

ALTER TABLE pracownik
    ADD CONSTRAINT pracownik_adres_fk FOREIGN KEY ( adres_id )
        REFERENCES adres ( id );

ALTER TABLE stan_zamowienia
    ADD CONSTRAINT stan_zamowienia_stan_fk FOREIGN KEY ( stan_id )
        REFERENCES stan ( id );

ALTER TABLE stan_zamowienia
    ADD CONSTRAINT stan_zamowienia_zamowienie_fk FOREIGN KEY ( zamowienie_id )
        REFERENCES zamowienie ( id );

ALTER TABLE zamowienie
    ADD CONSTRAINT zamowienie_klient_fk FOREIGN KEY ( klient_id )
        REFERENCES klient ( id );

ALTER TABLE zamowienie
    ADD CONSTRAINT zamowienie_pracownik_fk FOREIGN KEY ( pracownik_id )
        REFERENCES pracownik ( id );

CREATE SEQUENCE adres_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER adres_id_trg BEFORE
    INSERT ON adres
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := adres_id_seq.nextval;
END;
/

CREATE SEQUENCE autor_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER autor_id_trg BEFORE
    INSERT ON autor
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := autor_id_seq.nextval;
END;
/

CREATE SEQUENCE faktura_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER faktura_id_trg BEFORE
    INSERT ON faktura
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := faktura_id_seq.nextval;
END;
/

CREATE SEQUENCE kategoria_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER kategoria_id_trg BEFORE
    INSERT ON kategoria
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := kategoria_id_seq.nextval;
END;
/

CREATE SEQUENCE klient_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER klient_id_trg BEFORE
    INSERT ON klient
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := klient_id_seq.nextval;
END;
/

CREATE SEQUENCE koszyk_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER koszyk_id_trg BEFORE
    INSERT ON koszyk
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := koszyk_id_seq.nextval;
END;
/

CREATE SEQUENCE ksiazka_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER ksiazka_id_trg BEFORE
    INSERT ON ksiazka
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := ksiazka_id_seq.nextval;
END;
/

CREATE SEQUENCE pracownik_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER pracownik_id_trg BEFORE
    INSERT ON pracownik
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := pracownik_id_seq.nextval;
END;
/

CREATE SEQUENCE seria_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER seria_id_trg BEFORE
    INSERT ON seria
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := seria_id_seq.nextval;
END;
/

CREATE SEQUENCE stan_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER stan_id_trg BEFORE
    INSERT ON stan
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := stan_id_seq.nextval;
END;
/

CREATE SEQUENCE stan_zamowienia_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER stan_zamowienia_id_trg BEFORE
    INSERT ON stan_zamowienia
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := stan_zamowienia_id_seq.nextval;
END;
/

CREATE SEQUENCE wydawca_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER wydawca_id_trg BEFORE
    INSERT ON wydawca
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := wydawca_id_seq.nextval;
END;
/

CREATE SEQUENCE zamowienie_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER zamowienie_id_trg BEFORE
    INSERT ON zamowienie
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := zamowienie_id_seq.nextval;
END;
/