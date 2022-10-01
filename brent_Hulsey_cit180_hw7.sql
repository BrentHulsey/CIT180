--q1:
--Movie(Title, Date_of_Release, Original_Language, Category)
--PK: Title, Date_of_Release
--FK: Title references Movie_Title in Movie Performer
--FK: Date_of_Release references Movie_Date_of_Release in Movie Performer
--Movie Performer(Performer_Name, Performer_DOB, Movie_Title, Movie_Date_of_Release)
--PK: Performer_Name, Performer_DOB, Movie_Title, Movie_Date_of_Release
--FK: Performer_Name references Full_Name in Performer
--FK: Performer_DOB references Date_of_Birth in Performer
--Performer(Full_Name, Date_of_Birth, Gender, Country_of_Birth)
--PK: Full_Name, Date_of_Birth

--q:2
DROP TABLE RELATION CASCADE CONSTRAINTS;
CREATE TABLE RELATION (REL_ID int,RELATIVE varchar(30) PRIMARY KEY);

--q:3
INSERT INTO RELATION VALUES(100,'brother');
INSERT INTO RELATION VALUES(200,'sister');
INSERT INTO RELATION VALUES(300,'mom');
INSERT INTO RELATION VALUES(400,'dad');
--to verify
--SELECT * FROM RELATION

--q:4
--DROP TABLE MYDATA
CREATE TABLE MYDATA
( ID int,
  FNAME varchar(30),
  LNAME varchar(30),
  RELATIVE varchar(30),
  CONSTRAINT fk_RELATION
    FOREIGN KEY (RELATIVE)
    REFERENCES RELATION(RELATIVE)
);

--q:5
INSERT INTO MYDATA VALUES(1,'foo','bar','brother');
INSERT INTO MYDATA VALUES(2,'joe','bar','dad');
INSERT INTO MYDATA VALUES(3,'shark','tank','brother');
INSERT INTO MYDATA VALUES(4,'mary','tank','mom');
INSERT INTO MYDATA VALUES(5,'nancy','tank','sister');
--verify
--SELECT * FROM MYDATA

--q:6
INSERT INTO MYDATA VALUES(6,'bill','beck','uncle');
--Yes. Received ERROR [23000] [Oracle][ODBC][Ora]ORA-02291: integrity constraint (U7786G1.FK_RELATION) violated - parent key not found
--We tried inserting 'uncle' into the foreign key RELATIVE, but 'uncle' does not exist in the primary key RELATIVE in RELATION
--No. It will not be insterted into MYDATA.

--q:7
ALTER TABLE MYDATA  
  ADD (gender varchar(3),  
       middleinitial varchar(1));

--q:8
SELECT * FROM MYDATA
WHERE RELATIVE IN ('mom','dad');

--q:9
ALTER TABLE MYDATA
ADD PRIMARY KEY(ID);

--q:10
INSERT INTO MYDATA VALUES(3,'Ada','Lovelace','sister')
--Yes. Received ERROR [21S01] [Oracle][ODBC][Ora]ORA-00947: not enough values
--Since we added gender and middle initial columns (which is constrained by NOT NULL), gender and middle initial must be specified.
--We are also trying to add a PK which already exists. We can change the ID, gender, and middle initial to successfully insert.
--INSERT INTO MYDATA VALUES(10,'Ada','Lovelace','sister','f','f')
--No, it will not insert unless the edits above are made.
