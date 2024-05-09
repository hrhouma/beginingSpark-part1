# Importing necessary libraries
import json
from kafka import KafkaProducer
import time

# Configuration for Kafka producer
producer_conf = {
    # Set the bootstrap servers based on your Kafka cluster and host names
    # For example, 'your-host-name:9092'
    'bootstrap_servers': ['localhost:9092'],
    'value_serializer': lambda v: json.dumps(v).encode('utf-8')
}

# Creating Kafka producer instance
producer = KafkaProducer(**producer_conf)

# Define the topic name
topic_name = 'my-topic-test'

# Sending messages to Kafka
for i in range(100):
    message = {'this is message #': i}

    producer.send(topic_name, value=message)
    print(f'Message sent: {message}')
    time.sleep(1)

# Flush and close the producer
producer.flush()
producer.close()
