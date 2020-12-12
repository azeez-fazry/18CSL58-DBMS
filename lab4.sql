/*
	STUDENT (USN, SName, Address, Phone, Gender) 
	SEMSEC (SSID, Sem, Sec)
	CLASS (USN, SSID)
	SUBJECT (Subcode, Title, Sem, Credits)
	IAMARKS (USN, Subcode, SSID, Test1, Test2, Test3, FinalIA) 
	
	Write SQL queries to
	
	1. 	List all the student details studying in fourth semester 'C’section.
		
			SELECT *
    		FROM SEMSEC NATURAL JOIN CLASS NATURAL JOIN STUDENT
    		WHERE SEM=4 AND SEC='C';

	2. 	Compute the total number of male and female students in each semester
		and in each section.

			SELECT SS.SEM,SS.SEC,S.GENDER,COUNT(S.GENDER) TOTAL
			FROM STUDENT S NATURAL JOIN (SEMSEC SS NATURAL JOIN CLASS C)
			GROUP BY SS.SEM,SS.SEC,S.GENDER
			ORDER BY SEM;

	3. 	Create a view of Test1 marks of student USN '1BI15CS101’ in all subjects.
	
			CREATE VIEW TEST1_VIEW AS
    		SELECT SUBCODE,TEST1
    		FROM IAMARKS
    		WHERE USN = '1BI15CS101';
			SELECT * FROM TEST1_VIEW;

	4. 	Calculate the Final IA (average of best two test marks) and
		update the corresponding table for allstudents.
	
	5.	Categorize students based on the following criterion: 
		If FinalIA = 17 to 20 then
		CAT ='Outstanding’
		If FinalIA = 12 to 16 then CAT =
		'Average’ If FinalIA< 12 then CAT =
		'Weak’
		Give these details only for 8th semester A, B, and C section students. 
*/

DROP DATABASE IF EXISTS LAB4;
CREATE DATABASE LAB4;
USE LAB4;

DROP TABLE IF EXISTS STUDENT;
CREATE TABLE STUDENT (
	USN VARCHAR (10) PRIMARY KEY, 
	SNAME VARCHAR (64), 
	ADDRESS VARCHAR (64), 
	PHONE BIGINT (12), 
	GENDER CHAR (1)
);

DROP TABLE IF EXISTS SEMSEC;
CREATE TABLE SEMSEC (
	SSID VARCHAR (10) PRIMARY KEY, 
	SEM INT (5), 
	SEC VARCHAR (2)
);

DROP TABLE IF EXISTS CLASS;
CREATE TABLE CLASS (
	USN VARCHAR (10), 
	SSID VARCHAR (10),
	PRIMARY KEY(USN,SSID)
);
	
DROP TABLE IF EXISTS SUBJECT;
CREATE TABLE SUBJECT (
	SUBCODE VARCHAR (10) PRIMARY KEY, 
	TITLE VARCHAR (32), 
	SEM INT (5), 
	CREDITS INT (5)
);

DROP TABLE IF EXISTS IAMARKS;
CREATE TABLE IAMARKS (
	USN VARCHAR (10), 
	SUBCODE VARCHAR (10), 
	SSID VARCHAR (10), 
	TEST1 INT (5), 
	TEST2 INT (5), 
	TEST3 INT (5), 
	FINALIA  INT (5),
	PRIMARY KEY(USN,SUBCODE,SSID)
);

ALTER TABLE CLASS
	ADD FOREIGN KEY (USN) REFERENCES STUDENT (USN) ON DELETE CASCADE,
	ADD FOREIGN KEY (SSID) REFERENCES SEMSEC (SSID) ON DELETE CASCADE;
	
ALTER TABLE IAMARKS
	ADD FOREIGN KEY (USN) REFERENCES STUDENT (USN),
	ADD FOREIGN KEY (SUBCODE) REFERENCES SUBJECT (SUBCODE),
	ADD FOREIGN KEY (SSID) REFERENCES SEMSEC (SSID);
