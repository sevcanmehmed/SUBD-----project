set schema FN71981;

INSERT INTO DESTINATIONS(AIRPORTNAME,COUNTRY,CITY) VALUES ('SOFIA-AIRPORT','BULGARIA','SOFIA');
INSERT INTO DESTINATIONS(AIRPORTNAME,COUNTRY,CITY) VALUES ('BURGAS-AIRPORT','BULGARIA','BURGAS');
INSERT INTO DESTINATIONS(AIRPORTNAME,COUNTRY,CITY) VALUES ('VARNA-AIRPORT','BULGARIA','VARNA');
INSERT INTO DESTINATIONS(AIRPORTNAME,COUNTRY,CITY) VALUES ('HEATHROW-AIRPORT','ENGLAND','LONDON');

INSERT INTO AIRLINES(ANAME, PHONE, WEBSITE) VALUES('BULGARIA-AIR','024020400','http://www.air.bg');
INSERT INTO AIRLINES(ANAME, PHONE, WEBSITE) VALUES('WIZZ-AIR','090063949','http://wizzair.com/');
INSERT INTO AIRLINES(ANAME, PHONE, WEBSITE) VALUES('RYANAIR','+44 127935','www.ryanair.com');


INSERT INTO FLIGHTS(CODE, DURATION, DEPTTIME, DEPTDATE, ARRIVALTIME, ARRIVALDATE, DEPTERMINAL, ARRIVALTERMINAL, AIRLINESNAME, AIRPORTNAMEDEPT, AIRPORTNAMEARRIVAL)
VALUES ('FB974',30,'2021-05-23-22.00.00.000000','2021-05-23','2021-05-23-22.30.00.000000','2021-05-23',1,2,'BULGARIA-AIR','VARNA-AIRPORT','SOFIA-AIRPORT');
INSERT INTO FLIGHTS(CODE, DURATION, DEPTTIME, DEPTDATE, ARRIVALTIME, ARRIVALDATE, DEPTERMINAL, ARRIVALTERMINAL, AIRLINESNAME, AIRPORTNAMEDEPT, AIRPORTNAMEARRIVAL) VALUES ('W64301',70,'2021-05-22-06.15.00.000000','2021-05-22','2021-05-22-07.25.00.000000','2021-05-22',1,2,'WIZZ-AIR','SOFIA-AIRPORT','HEATHROW-AIRPORT');
INSERT INTO FLIGHTS(CODE, DURATION, DEPTTIME, DEPTDATE, ARRIVALTIME, ARRIVALDATE, DEPTERMINAL, ARRIVALTERMINAL, AIRLINESNAME, AIRPORTNAMEDEPT, AIRPORTNAMEARRIVAL) VALUES ('FB973',26,'2021-05-23-20.10.00.000000','2021-05-23','2021-05-23-20.36.00.000000','2021-05-23',2,1,'BULGARIA-AIR','SOFIA-AIRPORT','VARNA-AIRPORT');
INSERT INTO FLIGHTS(CODE, DURATION, DEPTTIME, DEPTDATE, ARRIVALTIME, ARRIVALDATE, DEPTERMINAL, ARRIVALTERMINAL, AIRLINESNAME, AIRPORTNAMEDEPT, AIRPORTNAMEARRIVAL) VALUES ('FB975',26,'10:15','2021-05-23','10:30','2021-05-23',2,1,'BULGARIA-AIR','SOFIA-AIRPORT','VARNA-AIRPORT');
INSERT INTO FLIGHTS(CODE, DURATION, DEPTTIME, DEPTDATE, ARRIVALTIME, ARRIVALDATE, DEPTERMINAL, ARRIVALTERMINAL, AIRLINESNAME, AIRPORTNAMEDEPT, AIRPORTNAMEARRIVAL)
VALUES ('FR6410',215,'08:10','2021-06-14','10:45','2021-06-14', 1, 2,'RYANAIR', 'MADRID-AIRPORT', 'SOFIA-AIRPORT');
INSERT INTO FLIGHTS(CODE, DURATION, DEPTTIME, DEPTDATE, ARRIVALTIME, ARRIVALDATE, DEPTERMINAL, ARRIVALTERMINAL, AIRLINESNAME, AIRPORTNAMEDEPT, AIRPORTNAMEARRIVAL)
VALUES ('FW6410',215,'23:15','2021-06-14','03:00','2021-07-14',NULL, NULL,'RYANAIR', 'SOFIA-AIRPORT', 'MADRID-AIRPORT');


UPDATE FLIGHTS
    SET DURATION = 40
WHERE CODE = 'FB974';

SELECT AIRPORTNAMEDEPT,AIRLINESNAME, AIRPORTNAMEARRIVAL
FROM FLIGHTS
WHERE AIRLINESNAME = 'BULGARIA-AIR';

DELETE  FROM DESTINATIONS
WHERE AIRPORTNAME = 'PARIS-AIRPORT';

SET SCHEMA FN71981;

SELECT F.AIRPORTNAMEDEPT AS FROM, F.AIRLINESNAME AS AIRLINES, F.AIRPORTNAMEARRIVAL AS TO, F.DEPTDATE AS DATE
FROM FLIGHTS F JOIN AIRLINES A
ON F.AIRLINESNAME = A.ANAME
WHERE F.AIRLINESNAME = 'BULGARIA-AIR';

SELECT AIRLINESNAME, SUM(DURATION)
FROM FLIGHTS
GROUP BY AIRLINESNAME;