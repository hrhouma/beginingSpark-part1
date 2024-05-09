import tweepy

from json import dumps
from kafka import KafkaProducer
from rich import print
from time import sleep

producer = KafkaProducer(bootstrap_servers=['vps-data1:9092','vps-data2:9092','vps-data3:9092'],
                         value_serializer=lambda K:dumps(K).encode('utf-8'))


# to read keys from secret txt file
with open('/path/to/secrets.txt') as f:
    for line in f:
        if '=' in line:
            key, value = line.strip().split(' = ')
            if key == 'CONSUMER_KEY':
                CONSUMER_KEY = value.strip("'")
            elif key == 'CONSUMER_SECRET':
                CONSUMER_SECRET = value.strip("'")
            elif key == 'ACCESS_TOKEN':
                ACCESS_TOKEN = value.strip("'")
            elif key == 'ACCESS_TOKEN_SECRET':
                ACCESS_TOKEN_SECRET = value.strip("'")


auth=tweepy.OAuthHandler(CONSUMER_KEY,CONSUMER_SECRET)
auth.set_access_token(ACCESS_TOKEN,ACCESS_TOKEN_SECRET)

api=tweepy.API(auth)
cursor=tweepy.Cursor(api.search_tweets,q='music', lang="en",tweet_mode='extended').items(100)

for tweet in cursor:
    hashtags=tweet.entities['hashtags']

    hashtext=list()
    for j in range(0, len(hashtags)):
        hashtext.append(hashtags[j]['text'])
    

    cur_data={
        "id_str": tweet.id_str,
        "username":tweet.user.name,
        "tweet":tweet.full_text,
        "location": tweet.user.location,
        "retweet_count": tweet.retweet_count,
        "favorite_count": tweet.favorite_count,
        "followers_count": tweet.user.followers_count,
        "lang": tweet.lang
    }
    # "coordinates": tweet.coordinates
    producer.send('my-topic-test', value=cur_data)
    print(cur_data)
    sleep(0.5)

