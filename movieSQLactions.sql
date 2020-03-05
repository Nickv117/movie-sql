-- 1. Select all columns and rows from the movies table


SELECT * from movies;




-- Select only the title and id of the first 10 rows

SELECT title, id from movies.movies

LIMIT 10;



-- Find the movie with the id of 485

SELECT title FROM movies.movies WHERE id=485;



-- Find the id (only that column) of the movie Made in America (1993)

SELECT id FROM movies.movies WHERE title = 'Made in America (1993)';

 


-- Find the first 10 sorted alphabetically

SELECT title FROM movies.movies ORDER BY title LIMIT 10;




-- Find all movies from 2002

SELECT title from movies.movies where title LIKE (%(2202)%)



-- Find out what year the Godfather came out


SELECT title FROM movies.movies WHERE title LIKE %Godfather, The%






-- Without using joins find all the comedies


SELECT title, genres from movies.movies where genres like %Comedy%





-- Find all comedies in the year 2000

SELECT title, genres
FROM movies.movies 
WHERE genres LIKE "%comedy%" AND title LIKE "%(2000)%";




-- Find any movies that are about death and are a comedy


SELECT title, genres
FROM movies.movies 
WHERE genres LIKE "%comedy%" AND title LIKE "%death%";





-- Find any movies from either 2001 or 2002 with a title containing super

SELECT title from movies.movies where title like "%super%" and "%(2001)%" or title like "%super%" and "%(2002)%"





-- Create a new table called actors (We are going to pretend the actor can only play in one movie). The table should include name, character name, foreign key to movies and date of birth at least plus an id field.

CREATE TABLE `movies`.`Actors` (
  `ID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `CharName` VARCHAR(45) NULL,
  `DOB` DATETIME NULL,
  PRIMARY KEY (`ID`));

-- Pick 3 movies and create insert statements for 10 actors each. You should use the multi value insert statements

insert into Actors(fullname, CharName, DOB, movieID)
values('Tommy Wiseau', 'Johhny', '1234-01-12', "24"),
('Greg Sestero', 'Mark', '1978-07-15/', "24"),
('Juliette Danielle', 'Lisa', '12-08-1980', "24"),
('Philip Haldiman', 'Denny', '09-25-1977', "24"),
('Dan Janjigian', 'Chris-R', '04-30-1972', "24"),
('Greg Ellery', 'Steven', '08-24-1971', "24"),
('Carolyn Minnott', 'Claudette', '03-20-1938', "24"),
('Robyn Paris', 'Michelle', '05-13-1975', "24"),
('Kyle Vogt', 'Peter', '06-14-1976', "24"),
('Nick Offerman', 'Ron', '09-22-1996', "24")

insert into Actors(fullname, CharName, DOB, movieID)
values('Tommy Wiseau', 'Mark', '1234-01-12', "68"),
('Greg Sestero', 'Johnny', '1978-07-15', "68"),
('Juliette Danielle', 'Claudette', '1980-12-08', "68"),
('Philip Haldiman', 'Chris-R', '1977-09-25'),
('Dan Janjigian', 'Denny', '1972-04-30', "68"),
('Greg Ellery', 'Peter', '1971-08-24', "68"),
('Carolyn Minnott', 'Michelle', '1938-03-20', "68"),
('Robyn Paris', 'Lisa', '1975-05-13'- "68"),
('Kyle Vogt', 'Steven', '1976-06-14', "68"),
('Nick Offerman', 'Swanson', '1996-09-22', "68")

insert into Actors(fullname, CharName, DOB, movieID)
values('Tommy Wiseau', 'Denny', '1234-01-12', "69"),
('Greg Sestero', 'Peter', '1978-07-15', "69"),
('Juliette Danielle', 'Michelle', '1980-12-08', "69"),
('Philip Haldiman', 'Denny', '1977-09-25', "69"),
('Dan Janjigian', 'Chris-R', '1972-04-30-', "69"),
('Greg Ellery', 'Steven', '1971-08-24', "69"),
('Carolyn Minnott', 'Lisa', '1938-03-20'- "69"),
('Robyn Paris', 'Claudette', '1975-05-13', "69"),
('Kyle Vogt', 'Peter', '1976-06-14', "69"),
('Nick Offerman', 'Nick', '1996-09-22', "69")




-- Create a new column in the movie table to hold the MPAA rating. UPDATE 5 different movies to their correct rating


alter table movies add MPAA_RATING varchar(50)

update movies set MPAA_RATING = 'PG'

where id = '7';


update movies set MPAA_RATING = 'PG-13'

where id = '19';


update movies set MPAA_RATING = 'PG-13'

where id = '153';


update movies set MPAA_RATING = 'PG'

where id = '169';


update movies set MPAA_RATING = 'G'

where id = '239';




//////////////////////////////////////////////////////////////////////////////////////////


-- Find all the ratings for the movie Godfather, show just the title and the rating

SELECT movies.title, ratings.rating
from movies.movies
LEFT JOIN ratings ON movies.id = ratings.movie_id
WHERE title LIKE '%Godfather, The%'

-- Order the previous objective by newest to oldest

SELECT movies.title, ratings.rating, ratings.timestamp
FROM movies.movies 
LEFT JOIN ratings ON movies.id = ratings.movie_id
WHERE title LIKE '%Godfather, The%'
ORDER BY timestamp DESC


-- Find the comedies from 2005 and get the title and imdbid from the links table

SELECT movie.title, links.imdb_id
FROM movies.movies
LEFT JOIN links ON movie.id = links.imdb_id
WHERE title LIKE '%(2005)%' AND genres LIKE '%comdey%'





-- Find all movies that have no ratings


SELECT movies.title, ratings.rating
FROM movies.movies
LEFT JOIN ratings ON movies.id = ratings.movie_id
WHERE ISNULL(ratings.rating)


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Get the average rating for a movie

SELECT AVG(rating) as avgRating
FROM ratings
WHERE movie_id='2'



-- Get the total ratings for a movie

SELECT SUM(rating) as ratingSum
FROM ratings
WHERE movie_id='2'



-- Get the total movies for a genre

SELECT COUNT(title) as countTitle
FROM movies
WHERE genres LIKE "%action%"



-- Get the average rating for a user

SELECT AVG(rating) as avgUserR
FROM ratings
WHERE user_id='1'



-- Find the user with the most ratings

SELECT user_id, COUNT(rating) as userCount
FROM ratings
GROUP BY user_id
ORDER BY userCount DESC



-- Find the user with the highest average rating

SELECT AVG(rating) as highAvg
FROM ratings
GROUP BY user_id
HAVING average = (
  SELECT MAX(average)
  FROM (
    SELECT AVG(rating) as average
    FROM ratings
    GROUP BY user_id
  ) as avgHighRating
)



-- Find the user with the highest average rating with more than 50 reviews

SELECT user_id, ROUND(AVG(rating),2) AS ratingAvg, COUNT(rating) as ratingCount
FROM ratings
GROUP BY `user_id`
HAVING ratingCount > 50
ORDER BY ratingAvg DESC



-- Find the movies with an average rating over 4


SELECT movie_id, ROUND(AVG(rating),2) as ratingAvg
FROM ratings
GROUP BY movie_id
HAVING ratingAvg > 4
ORDER BY ratingAvg DESC