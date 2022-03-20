SET SCHEMA FN71981;

CREATE TRIGGER CHECK_FLIGHT_DATE
    BEFORE INSERT ON FN71981.FLIGHTS
       REFERENCING NEW AS N
       FOR EACH ROW
    WHEN (N.ARRIVALDATE > N.DEPTDATE)
    SET N.ARRIVALDATE = '2022-01-01';