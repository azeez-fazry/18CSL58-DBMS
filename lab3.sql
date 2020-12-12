/*
	ACTOR (Act_id, Act_Name, Act_Gender)
	DIRECTOR (Dir_id, Dir_Name, Dir_Phone)
	MOVIES (Mov_id, Mov_Title, Mov_Year, Mov_Lang, Dir_id) 
	MOVIE_CAST (Act_id, Mov_id, Role)
	RATING (Mov_id, Rev_Stars) 
	
	Write SQL queries to
	
	1. 	List the titles of all movies directed by'Hitchcock’.
		
			SELECT MOV_TITLE
		    FROM DIRECTOR NATURAL JOIN MOVIES
		    WHERE DIR_NAME='Hitchcock';
		
	2. 	Find the movie names where one or more actors acted in two or more movies.

			SELECT MOV_TITLE
    	 	FROM MOVIE_CAST NATURAL JOIN MOVIES
    	 	WHERE ACT_ID IN (SELECT ACT_ID
    	 	FROM MOVIE_CAST NATURAL JOIN MOVIES
    	 	GROUP BY ACT_ID
    	 	HAVING COUNT(*)>0)
    	 	GROUP BY MOV_TITLE
    		HAVING COUNT(*)>1;

	3. 	List all actors who acted in a movie before 2000 and also in a
		movieafter 2015 (use JOIN operation).
	
			SELECT A.ACT_ID,A.ACT_NAME
			FROM MOVIES M, MOVIE_CAST MC,ACTOR A
			WHERE A.ACT_ID=MC.ACT_ID AND MC.MOV_ID=M.MOV_ID AND M.MOV_YEAR NOT BETWEEN 2000 AND 2015;

	4.	Find the title of movies and number of stars for each movie that has at
		least one rating and find the highest number of stars that movie received.
		Sort the result by movie title.

			SELECT MOV_TITLE,MAX(REV_STARS) MAX_RATING
   			FROM MOVIES NATURAL JOIN RATING
    		GROUP BY MOV_TITLE
    		HAVING MIN(REV_STARS)>0
			
			
	5. 	Update rating of all movies directed by 'Steven Spielberg’ to5. 
	
			UPDATE RATING
			SET REV_STARS=5
			WHERE MOV_ID IN(SELECT M.MOV_ID
			FROM DIRECTOR NATURAL JOIN MOVIES M
			WHERE DIR_NAME='Steven Spielberg');

*/

DROP DATABASE IF EXISTS LAB3;
CREATE DATABASE LAB3;
USE LAB3;

DROP TABLE IF EXISTS ACTOR;
CREATE TABLE ACTOR(
	ACT_ID INT (20) PRIMARY KEY,
	ACT_NAME VARCHAR (20),
	ACT_GENDER CHAR (1)
);

DROP TABLE IF EXISTS DIRECTOR;
CREATE TABLE DIRECTOR (
	DIR_ID INT (20) PRIMARY KEY,
	DIR_NAME VARCHAR (64),
	DIR_PHONE VARCHAR (12)
);

DROP TABLE IF EXISTS MOVIES;
CREATE TABLE MOVIES (
	MOV_ID INT (20) PRIMARY KEY,
	MOV_TITLE VARCHAR (25),
	MOV_YEAR INT (20),
	MOV_LANG VARCHAR (12),
	DIR_ID INT (20)
);

DROP TABLE IF EXISTS MOVIE_CAST;
CREATE TABLE MOVIE_CAST ( 
	ACT_ID INT (20),
	MOV_ID INT (20),
	ROLE VARCHAR(10),
	PRIMARY KEY(ACT_ID,MOV_ID)
);

DROP TABLE IF EXISTS RATING;
CREATE TABLE RATING (
	MOV_ID INT (20) PRIMARY KEY,
	REV_STARS VARCHAR (25)
);

ALTER TABLE MOVIES ADD FOREIGN KEY (DIR_ID) REFERENCES DIRECTOR (DIR_ID);

ALTER TABLE MOVIE_CAST
	ADD FOREIGN KEY (ACT_ID) REFERENCES ACTOR (ACT_ID),
	ADD FOREIGN KEY (MOV_ID) REFERENCES MOVIES (MOV_ID);
	
ALTER TABLE RATING ADD FOREIGN KEY (MOV_ID) REFERENCES MOVIES (MOV_ID);

