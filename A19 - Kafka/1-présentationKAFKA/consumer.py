# Importing necessary libraries
from kafka import KafkaConsumer
import json

# Configuration for Kafka consumer
consumer_conf = {
    # Set the bootstrap servers based on your Kafka cluster and host names
    # For a single node (localhost) setup, use 'localhost:9092'
    'bootstrap_servers': ['localhost:9092'],
    'group_id': 'my_group',
    'auto_offset_reset': 'latest',
    'value_deserializer': lambda v: json.loads(v.decode('utf-8'))
}

# Creating Kafka consumer instance
consumer = KafkaConsumer('my-topic-test', **consumer_conf)

# Consuming messages from Kafka
for message in consumer:
    print(f"Received message: {message.value}")

# Closing the consumer
consumer.close()
