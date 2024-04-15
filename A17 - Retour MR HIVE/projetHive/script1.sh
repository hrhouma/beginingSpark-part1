#!/usr/bin/env bash
#--CREATE A DIRECTORY NAMED movieRecomendationsSystem
mkdir /home/cloudera/Desktop/movieRecomendationsSystem 
export DIRX=/home/cloudera/Desktop/movieRecomendationsSystem
cd $DIRX
#--FETCH THE FILES
wget http://files.grouplens.org/datasets/movielens/ml-1m.zip
wget http://files.grouplens.org/datasets/movielens/ml-100k.zip
wget http://files.grouplens.org/datasets/movielens/ml-latest.zip

#--UNZIP THE FILES
unzip ml-100k.zip
unzip ml-1m.zip
unzip ml-latest.zip

#--PERMISSIONS
cd ..
chmod -R 777 $DIRX

#--CREATE DIRECTORIES FOR 100 , MILLION LATEST
hdfs dfs -mkdir -p hackerday_ratings/100k
hdfs dfs -mkdir -p hackerday_ratings/million
hdfs dfs -mkdir -p hackerday_ratings/latest

#--RENAME FILE NAMES
mv ml-100k 100k
mv ml-1m million
mv  ml-latest latest

#--CREATE DIRECTORY IN HDFS FOR 100K RECORDS
hdfs dfs -mkdir -p hackerday_ratings/100k/data
hdfs dfs -mkdir -p hackerday_ratings/100k/item
hdfs dfs -mkdir -p hackerday_ratings/100k/info
hdfs dfs -mkdir -p hackerday_ratings/100k/genre
hdfs dfs -mkdir -p hackerday_ratings/100k/user
hdfs dfs -mkdir -p hackerday_ratings/100k/occupation


#--COPY FROM LOCAL TO HDFS
hdfs dfs -copyFromLocal $DIRX/100k/u.data hackerday_ratings/100k/data
hdfs dfs -copyFromLocal $DIRX/100k/u.item hackerday_ratings/100k/item
hdfs dfs -copyFromLocal $DIRX/100k/u.info hackerday_ratings/100k/info
hdfs dfs -copyFromLocal $DIRX/100k/u.genre hackerday_ratings/100k/genre
hdfs dfs -copyFromLocal $DIRX/100k/u.user hackerday_ratings/100k/user
hdfs dfs -copyFromLocal $DIRX/100k/u.data hackerday_ratings/100k/occupation


#--GET THE SERDE AND SNAPSHOT JAR FILE
#wget https://s3.amazonaws.com/hackerday.bigdata/37/hive-serdes-1.0-SNAPSHOT.jar
#wget https://s3.amazonaws.com/hackerday.bigdata/37/flume-sources-1.0-SNAPSHOT.jar
#wget https://github.com/downloads/ogrodnek/csv-serde/csv-serde-1.1.2.jar


#--GET THE SERDE AND SNAPSHOT JAR FILE
wget https://github.com/hrhouma/filescsv-serde/blob/main/hive-serdes-1.0-SNAPSHOT.jar 
wget https://github.com/hrhouma/filescsv-serde/blob/main/csv-serde-1.1.2-0.11.0-all.jar
wget https://github.com/hrhouma/filescsv-serde/blob/main/csv-serde-1.1.2-0.11.0.jar
wget https://github.com/hrhouma/filescsv-serde/blob/main/csv-serde-1.1.2.jar
wget https://github.com/hrhouma/filescsv-serde/blob/main/flume-sources-1.0-SNAPSHOT.jar
wget https://github.com/hrhouma/filescsv-serde/blob/main/hive-serdes-1.0-SNAPSHOT.jar

#--COPY THE SERDE JAR FILE TO HDFS
hdfs dfs -copyFromLocal $DIRX/csv-serde-1.1.2.jar  hackerday_ratings/

#--RENAME DAT FILES
cd million
mv movies.dat movies
mv ratings.dat ratings
mv users.dat users


#--REPLACE "--" WITH "@"
sed 's/::/@/g' $DIRX/million/ratings > $DIRX/million/ratings_clean 
hdfs dfs -mkdir -p hackerday_ratings/million/ratings
hdfs dfs -copyFromLocal $DIRX/million/ratings_clean hackerday_ratings/million/ratings

sed 's/::/@/g' $DIRX/million/users > $DIRX/million/users_clean 
hdfs dfs -mkdir -p hackerday_ratings/million/users
hdfs dfs -copyFromLocal $DIRX/million/users_clean hackerday_ratings/million/users

sed 's/::/@/g' $DIRX/million/movies > $DIRX/million/movies_clean 
hdfs dfs -mkdir -p hackerday_ratings/million/movies
hdfs dfs -copyFromLocal $DIRX/million/movies_clean hackerday_ratings/million/movies

#--CREATE DIRECTORIES FOR LATEST
hdfs dfs -mkdir -p hackerday_ratings/latest/ratings
hdfs dfs -mkdir -p hackerday_ratings/latest/links
hdfs dfs -mkdir -p hackerday_ratings/latest/movies
hdfs dfs -mkdir -p hackerday_ratings/latest/tags
hdfs dfs -mkdir -p hackerday_ratings/latest/scores

#--MOVE THE FILES TO THE HDFS LOCATION
hdfs dfs -copyFromLocal $DIRX/latest/ratings.csv hackerday_ratings/latest/ratings
hdfs dfs -copyFromLocal $DIRX/latest/links.csv hackerday_ratings/latest/links
hdfs dfs -copyFromLocal $DIRX/latest/movies.csv hackerday_ratings/latest/movies
hdfs dfs -copyFromLocal $DIRX/latest/tags.csv hackerday_ratings/latest/tags

