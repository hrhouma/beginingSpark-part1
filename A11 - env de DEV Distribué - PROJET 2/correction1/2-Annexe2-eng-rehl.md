# Kafka Setup on Amazon Linux 2023

## Introduction
This guide provides step-by-step instructions to set up Kafka, Zookeeper, and Docker on an Amazon Linux 2023 instance. It covers copying the Docker Compose file, installing Docker and Docker Compose, and setting up Kafka with Python clients.

## Part 1: Copy Docker Compose File to the Amazon Linux Machine
1. SSH into your Amazon Linux machine:
   ```sh
   ssh -i "master.pem" ec2-user@35.175.171.81 \
   -L 2081:localhost:2041 -L 4888:localhost:4888 \
   -L 2080:localhost:2080 -L 27017:localhost:27017 \
   -L 28017:localhost:28017 -L 8050:localhost:8050 \
   -L 4141:localhost:4141 -L 3880:localhost:3880
   ```

2. Gain root privileges and create a directory to store the Docker Compose file:
   ```sh
   sudo -s
   cd /home/ec2-user/
   mkdir docker_exp
   ```

3. Copy the Docker Compose file to the Amazon Linux machine:
   ```sh
   scp -r -i "master.pem" docker-compose.yml \
   ec2-user@35.175.171.81:/home/ec2-user/docker_exp
   ```

## Part 2: Install Docker
1. Update the system and install Docker:
   ```sh
   yum update
   yum install -y docker
   ```

2. Start the Docker service and verify the installation:
   ```sh
   sudo systemctl start docker
   docker ps
   ```

## Part 3: Install Docker Compose
1. Download and install Docker Compose:
   ```sh
   sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
   sudo chmod +x /usr/local/bin/docker-compose
   ```

2. Verify the installation:
   ```sh
   docker-compose version
   ```

## Part 4: Set Up Kafka with Python Clients
1. Start the Kafka services using Docker Compose:
   ```sh
   docker-compose up -d
   ```

2. Set up a Python virtual environment and install the Kafka Python client:
   ```sh
   sudo yum install -y python3
   python3 -m venv kafka_env
   source kafka_env/bin/activate
   pip install kafka-python
   ```

3. Create a Kafka consumer (`consumer.py`):
   ```python
   from kafka import KafkaConsumer
   import json

   # Initialize consumer
   consumer = KafkaConsumer(
       'test-topic',
       bootstrap_servers=['localhost:19092', 'localhost:29092', 'localhost:39092'],
       value_deserializer=lambda v: json.loads(v.decode('utf-8')),
       auto_offset_reset='earliest',
       enable_auto_commit=True,
       group_id='test-group'
   )

   # Consume messages
   for message in consumer:
       print(f'Received: {message.value}')
   ```

4. Create a Kafka producer (`producer.py`):
   ```python
   from kafka import KafkaProducer
   import json
   import time

   # Configure the Kafka producer
   producer = KafkaProducer(
       bootstrap_servers=['localhost:19092', 'localhost:29092', 'localhost:39092'],
       value_serializer=lambda v: json.dumps(v).encode('utf-8')
   )

   # Send messages to Kafka with a delay between each message
   for i in range(10):
       message = {'key': i, 'message': f'Hello Kafka {i}'}
       producer.send('test-topic', message)
       print(f'Sent: {message}')
       time.sleep(2)  # Introduce a 2-second delay

   # Ensure all messages are sent
   producer.flush()
   ```

5. Run the producer and consumer:
   ```sh
   python producer.py
   python consumer.py
   ```

## Reference
- [Docker Compose Example for Kafka, Zookeeper, and Schema Registry](https://jskim1991.medium.com/docker-docker-compose-example-for-kafka-zookeeper-and-schema-registry-c516422532e7)
```

Let me know if you need any modifications or have additional information to add.
