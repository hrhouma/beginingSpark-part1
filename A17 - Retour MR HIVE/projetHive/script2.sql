--SET hive.execution.engine=tez;

drop table if exists 100k_data;
drop table if exists 100k_info;
drop table if exists 100k_genre;
drop table if exists 100k_user;
drop table if exists 100k_item;
drop table if exists 100k_occupation;
drop table if exists million_users;
drop table million_ratings;
drop table if exists million_movies;
drop table if exists latest_ratings;
drop table if exists latest_movies;
drop table if exists latest_links;
drop table if exists latest_tags;

drop table if exists latest_ratings_serde;
drop table if exists latest_movies_serde;
drop table if exists latest_links_serde;
drop table if exists latest_tags_serde;




create external table 100k_data (
user_id int,
item_id int,
rating double,
rating_time bigint)
row format delimited
fields terminated by '\t'
lines terminated by '\n'
location '/user/cloudera/hackerday_ratings/100k/data';


create external table 100k_item
(
movie_id int,
movie_title varchar(100),
release_date string,
video_release_date string,
IMDB_URL varchar(5000),
unknown tinyint,
Action tinyint,
Adventure tinyint,
Animation tinyint,
Children tinyint,
Comedy tinyint,
Crime tinyint,
Documentry tinyint,
Drama tinyint,
Fantasy tinyint,
Film_Noir tinyint,
Horror tinyint,
Musical tinyint,
Mystery tinyint,
Romance tinyint,
Sci_Fi tinyint,
Thriller tinyint,
War tinyint,
Western tinyint
)
row format delimited
fields terminated by '||'
lines terminated by '\n'
location '/user/cloudera/hackerday_ratings/100k/item';


create external table 100k_info (
no int,
type varchar(100)
)
row format delimited
fields terminated by ' '
lines terminated by '\n'
location '/user/cloudera/hackerday_ratings/100k/info';



create external table 100k_genre (
type varchar(100),
value tinyint
)
row format delimited
fields terminated by '|'
lines terminated by '\n'
location '/user/cloudera/hackerday_ratings/100k/genre';



create external table 100k_user (
user_id varchar(100),
age tinyint,
gender varchar(5),
occupation varchar(100),
zipcode int
)
row format delimited
fields terminated by '|'
lines terminated by '\n'
location '/user/cloudera/hackerday_ratings/100k/user';


create external table 100k_occupation (
type varchar(100)
)
row format delimited
fields terminated by ''
lines terminated by '\n'
location '/user/cloudera/hackerday_ratings/100k/occupation';


drop table if exists 100k_genre;
create external table 100k_genre (
type varchar(100),
value tinyint
)
row format delimited
fields terminated by '|'
lines terminated by '\n'
location '/user/cloudera/hackerday_ratings/100k/genre'
TBLPROPERTIES ("skip.footer.line.count" = "1");



create external table million_users (
user_id int,
gender char(1),
age tinyint,
occupation varchar(20),
zip_code varchar(10)
)
row format delimited
fields terminated by '@'
lines terminated by '\n'
location '/user/cloudera/hackerday_ratings/million/users';


create external table million_ratings (
user_id int,
movie_id int,
rating double,
rating_time bigint
)
row format delimited
fields terminated by '@'
lines terminated by '\n'
location '/user/cloudera/hackerday_ratings/million/ratings';


create external table million_movies(
movie_id int,
title varchar(200),
genre varchar(100)
)
row format delimited
fields terminated by '@'
lines terminated by '\n'
location '/user/cloudera/hackerday_ratings/million/movies';



create external table latest_ratings (
user_id int,
movie_id int,
rating double,
rating_time bigint
)
row format delimited
fields terminated by ','
lines terminated by '\n'
location '/user/cloudera/hackerday_ratings/latest/ratings'
TBLPROPERTIES ("skip.header.line.count" = "1");


create external table latest_movies(
movie_id int,
title varchar(200),
genre varchar(200)
)
row format delimited
fields terminated by ','
lines terminated by '\n'
location '/user/cloudera/hackerday_ratings/latest/movies'
TBLPROPERTIES ("skip.header.line.count" = "1");




create external table latest_links(
movie_id int,
imdbid varchar(10),
tmbid int
)
row format delimited
fields terminated by ','
lines terminated by '\n'
location '/user/cloudera/hackerday_ratings/latest/links'
TBLPROPERTIES ("skip.header.line.count" = "1");


create external table latest_tags(
user_id int,
movie_id int,
tag varchar(500),
rating_time bigint
)
row format delimited
fields terminated by ','
lines terminated by '\n'
location '/user/cloudera/hackerday_ratings/latest/tags'
TBLPROPERTIES ("skip.header.line.count" = "1");



create external table latest_ratings_serde(
user_id string,
movie_id string,
rating string,
rating_time string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"seperatorChar"= "\,",
"quoteChar" = "\""
)
location '/user/cloudera/hackerday_ratings/latest/ratings'
TBLPROPERTIES ("skip.header.line.count" = "1");



create external table latest_movies_serde(
movie_id string,
title string,
genre string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"seperatorChar"= "\,",
"quoteChar" = "\""
)
location '/user/cloudera/hackerday_ratings/latest/movies'
TBLPROPERTIES ("skip.header.line.count" = "1");



create external table latest_links_serde(
movie_id string,
imdbid string,
tmbid string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"seperatorChar"= "\,",
"quoteChar" = "\""
)
location '/user/cloudera/hackerday_ratings/latest/links'
TBLPROPERTIES ("skip.header.line.count" = "1");



create external table latest_tags_serde(
user_id string,
movie_id string,
tag string,
rating_time string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"seperatorChar"= "\,",
"quoteChar" = "\""
)
location '/user/cloudera/hackerday_ratings/latest/tags'
TBLPROPERTIES ("skip.header.line.count" = "1");

--RECREATING TABLES WITH APPROPRIATE DATA TYPES FOR ANALYSIS
--LATEST RATING TABLE
drop table if exists latest_ratings;
create table latest_ratings as 
select cast (user_id as int) user_id, 
cast (movie_id as int) movie_id, 
cast (rating as double) rating ,  
cast (rating_time as bigint) rating_time
from latest_ratings_serde;

--LATEST MOVIE TABLE
drop table if exists latest_movies;
create table latest_movies as
select cast(movie_id as int) movie_id,
cast(title as varchar(200)) title,
cast(genre as varchar(200)) genre
from latest_movies_serde;

--LATEST LINK TABLE
drop table if exists latest_links;
create table latest_links as
select cast (movie_id  as int) as movie_id,
cast (imdbid as varchar(10)) as imdbid,
cast (tmbid as int) as tmbid
from latest_links_serde;

--LATEST TAGS TABLE
drop table if exists latest_tags;
create table latest_tags as
select cast(user_id as int) user_id,
cast (movie_id as int) movie_id,
cast (tag as varchar(500)) tag,
cast (rating_time as bigint) rating_time
from latest_tags_serde;
