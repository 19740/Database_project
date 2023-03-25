SET SERVEROUTPUT PUT
/
--View of customers who have paid invoices in 2021 and counting invoices for a specific customer

CREATE VIEW faktura_2021
AS
select k.imie, k.nazwisko, f.klient_id, COUNT (*) AS ilosc
FROM klient k   JOIN faktura f  ON k.id=f.klient_id
WHERE k.id IN (select klient_id FROM faktura WHERE data_platnosci BETWEEN TO_DATE('2021-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
                            AND TO_DATE('2021-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS'))
group by k.imie, k.nazwisko, klient_id;
/
SELECT * FROM faktura_2021


-- A view that added a column summing up all customer deliveries and displaying basic customer data if their deliveries were not free

CREATE VIEW dostawy
AS
SELECT k.imie, k.nazwisko, z.klient_id, SUM(z.cena_dostawy) AS Cena_wszystkich_dostaw
FROM klient k  JOIN zamowienie z ON k.id = z.klient_id
WHERE z.klient_id in (select id FROM klient WHERE COALESCE(z.cena_dostawy, 0) > 0) 
GROUP BY k.imie, k.nazwisko, z.klient_id;
/
SELECT * FROM dostawy;

