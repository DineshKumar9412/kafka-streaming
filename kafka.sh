#!/bin/bash

sudo apt-get update
#sudo apt install openjdk-8-jdk -y

#Downloading Kafka files and untarring
wget https://dlcdn.apache.org/kafka/3.2.0/kafka_2.13-3.2.0.tgz

tar xzf kafka_2.13-3.2.0.tgz

mv kafka_2.13-3.2.0 kafka

rm -rf kafka_2.13-3.2.0.tgz

mkdir kafka/data
mkdir kafka/ssl

mkdir kafka/data/zookeeper
mkdir kafka/data/broker-0
mkdir kafka/data/broker-1
mkdir kafka/data/broker-2

#Install Debezium
wget https://repo1.maven.org/maven2/io/debezium/debezium-connector-mysql/1.9.5.Final/debezium-connector-mysql-1.9.5.Final-plugin.tar.gz
tar -xvzf debezium-connector-mysql-1.9.5.Final-plugin.tar.gz
mkdir kafka/conns
rm -rf debezium-connector-mysql-1.9.5.Final-plugin.tar.gz
cp -r /home/user/debezium-connector-mysql /home/user/kafka/conns/
chmod 777 /home/user/kafka/conns/debezium-connector-mysql/*


sed -i 's|/tmp/zookeeper|/home/user/kafka/data/zookeeper|g' kafka/config/zookeeper.properties
sed -i 's|admin.enableServer=false|admin.enableServer=true|g' kafka/config/zookeeper.properties
sed -i 's|# admin.serverPort=8080|admin.serverPort=9090|g' kafka/config/zookeeper.properties
echo "serve.1=localhost:2888:3888" >> kafka/config/zookeeper.properties

echo "" >> kafka/config/zookeeper.properties
echo "" >> kafka/config/zookeeper.properties

echo "secureClientPort=2182" >> kafka/config/zookeeper.properties
echo "authProvider.x509=org.apache.zookeeper.server.auth.X509AuthenticationProvider" >> kafka/config/zookeeper.properties
echo "serverCnxnFactory=org.apache.zookeeper.server.NettyServerCnxnFactory" >> kafka/config/zookeeper.properties
echo "ssl.trustStore.location=/home/user/kafka/ssl/kafka.zookeeper.truststore.jks" >> kafka/config/zookeeper.properties
echo "ssl.trustStore.password=qwerty" >> kafka/config/zookeeper.properties
echo "ssl.keyStore.location=/home/user/kafka/ssl/kafka.zookeeper.keystore.jks" >> kafka/config/zookeeper.properties
echo "ssl.keyStore.password=asdfgh" >> kafka/config/zookeeper.properties
echo "ssl.clientAuth=need" >> kafka/config/zookeeper.properties

echo "zookeeper.connect=localhost:2182" >> kafka/config/zookeeper-client.properties
echo "zookeeper.clientCnxnSocket=org.apache.zookeeper.ClientCnxnSocketNetty" >> kafka/config/zookeeper-client.properties
echo "zookeeper.ssl.client.enable=true" >> kafka/config/zookeeper-client.properties
echo "zookeeper.ssl.protocol=TLSv1.2" >> kafka/config/zookeeper-client.properties
echo "zookeeper.ssl.truststore.location=/home/user/kafka/ssl/kafka.zookeeper-client.truststore.jks" >> kafka/config/zookeeper-client.properties
echo "zookeeper.ssl.truststore.password=qwerty" >> kafka/config/zookeeper-client.properties
echo "zookeeper.ssl.keystore.location=/home/user/kafka/ssl/kafka.zookeeper-client.keystore.jks" >> kafka/config/zookeeper-client.properties
echo "zookeeper.ssl.keystore.password=asdfgh" >> kafka/config/zookeeper-client.properties

cp -r kafka/config/server.properties kafka/config/server-1.properties
cp -r kafka/config/server.properties kafka/config/server-2.properties 


sed -i 's|#listeners=PLAINTEXT://:9092|listeners=SASL_SSL://localhost:9092|g' kafka/config/server.properties
sed -i 's|#advertised.listeners=PLAINTEXT://your.host.name:9092|advertised.listeners=SASL_SSL://localhost:9092|g' kafka/config/server.properties
sed -i 's|broker.id=0|broker.id=0|g' kafka/config/server.properties
sed -i 's|num.partitions=1|num.partitions=2|g' kafka/config/server.properties
sed -i 's|zookeeper.connect=localhost:2181|zookeeper.connect=localhost:2182|g' kafka/config/server.properties
sed -i 's|/tmp/kafka-logs|/home/user/kafka/data/broker-0|g' kafka/config/server.properties


echo "" >> kafka/config/server.properties
echo "" >> kafka/config/server.properties
echo "" >> kafka/config/server.properties
echo "zookeeper.clientCnxnSocket=org.apache.zookeeper.ClientCnxnSocketNetty" >> kafka/config/server.properties
echo "zookeeper.ssl.client.enable=true" >> kafka/config/server.properties
echo "zookeeper.ssl.protocol=TLSv1.2" >> kafka/config/server.properties
echo "zookeeper.ssl.truststore.location=/home/user/kafka/ssl/kafka.broker0.truststore.jks" >> kafka/config/server.properties
echo "zookeeper.ssl.truststore.password=qwerty" >> kafka/config/server.properties
echo "zookeeper.ssl.keystore.location=/home/user/kafka/ssl/kafka.broker0.keystore.jks" >> kafka/config/server.properties
echo "zookeeper.ssl.keystore.password=asdfgh" >> kafka/config/server.properties
echo "zookeeper.set.acl=true" >> kafka/config/server.properties
echo "" >> kafka/config/server.properties
echo "" >> kafka/config/server.properties
echo "ssl.truststore.location=/home/user/kafka/ssl/kafka.broker0.truststore.jks" >> kafka/config/server.properties
echo "ssl.truststore.password=qwerty" >> kafka/config/server.properties
echo "ssl.keystore.location=/home/user/kafka/ssl/kafka.broker0.keystore.jks" >> kafka/config/server.properties
echo "ssl.keystore.password=asdfgh" >> kafka/config/server.properties
echo "ssl.key.password=asdfgh" >> kafka/config/server.properties
echo "security.inter.broker.protocol=SASL_SSL" >> kafka/config/server.properties
echo "ssl.client.auth=none" >> kafka/config/server.properties
echo "ssl.protocol=TLSv1.2" >> kafka/config/server.properties
echo "" >> kafka/config/server.properties
echo "" >> kafka/config/server.properties
echo "delete.topic.enable=true" >> kafka/config/server.properties  
echo "" >> kafka/config/server.properties
echo "" >> kafka/config/server.properties
echo "#Properties for SASL between a broker and its client" >> kafka/config/server.properties
echo "sasl.enabled.mechanisms=SCRAM-SHA-512" >> kafka/config/server.properties
echo "sasl.mechanism.inter.broker.protocol=SCRAM-SHA-512" >> kafka/config/server.properties
echo "listener.name.sasl_ssl.scram-sha-512.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username=\"admin\" password=\"admin-secret\";" >> kafka/config/server.properties
echo "super.users=User:admin" >> kafka/config/server.properties
echo "#Properties for Authorization" >> kafka/config/server.properties
echo "authorizer.class.name=kafka.security.authorizer.AclAuthorizer" >> kafka/config/server.properties

sed -i 's|/tmp/kafka-logs|/home/user/kafka/data/broker-1|g' kafka/config/server-1.properties
sed -i 's|#listeners=PLAINTEXT://:9092|listeners=SASL_SSL://localhost:9093|g' kafka/config/server-1.properties
sed -i 's|#advertised.listeners=PLAINTEXT://your.host.name:9092|advertised.listeners=SASL_SSL://localhost:9093|g' kafka/config/server-1.properties
sed -i 's|broker.id=0|broker.id=1|g' kafka/config/server-1.properties
sed -i 's|num.partitions=1|num.partitions=2|g' kafka/config/server-1.properties
sed -i 's|zookeeper.connect=localhost:2181|zookeeper.connect=localhost:2182|g' kafka/config/server-1.properties

echo "" >> kafka/config/server-1.properties
echo "" >> kafka/config/server-1.properties
echo "" >> kafka/config/server-1.properties
echo "zookeeper.clientCnxnSocket=org.apache.zookeeper.ClientCnxnSocketNetty" >> kafka/config/server-1.properties
echo "zookeeper.ssl.client.enable=true" >> kafka/config/server-1.properties
echo "zookeeper.ssl.protocol=TLSv1.2" >> kafka/config/server-1.properties
echo "zookeeper.ssl.truststore.location=/home/user/kafka/ssl/kafka.broker1.truststore.jks" >> kafka/config/server-1.properties
echo "zookeeper.ssl.truststore.password=qwerty" >> kafka/config/server-1.properties
echo "zookeeper.ssl.keystore.location=/home/user/kafka/ssl/kafka.broker1.keystore.jks" >> kafka/config/server-1.properties
echo "zookeeper.ssl.keystore.password=asdfgh" >> kafka/config/server-1.properties
echo "zookeeper.set.acl=true" >> kafka/config/server-1.properties
echo "" >> kafka/config/server-1.properties
echo "" >> kafka/config/server-1.properties
echo "ssl.truststore.location=/home/user/kafka/ssl/kafka.broker1.truststore.jks" >> kafka/config/server-1.properties
echo "ssl.truststore.password=qwerty" >> kafka/config/server-1.properties
echo "ssl.keystore.location=/home/user/kafka/ssl/kafka.broker1.keystore.jks" >> kafka/config/server-1.properties
echo "ssl.keystore.password=asdfgh" >> kafka/config/server-1.properties
echo "ssl.key.password=asdfgh" >> kafka/config/server-1.properties
echo "security.inter.broker.protocol=SASL_SSL" >> kafka/config/server-1.properties
echo "ssl.client.auth=required" >> kafka/config/server-1.properties
echo "ssl.protocol=TLSv1.2" >> kafka/config/server-1.properties
echo "" >> kafka/config/server-1.properties
echo "" >> kafka/config/server-1.properties
echo "delete.topic.enable=true" >> kafka/config/server-1.properties
echo "" >> kafka/config/server-1.properties
echo "" >> kafka/config/server-1.properties
echo "#Properties for SASL between a broker and its client" >> kafka/config/server-1.properties
echo "sasl.enabled.mechanisms=SCRAM-SHA-512" >> kafka/config/server-1.properties
echo "sasl.mechanism.inter.broker.protocol=SCRAM-SHA-512" >> kafka/config/server-1.properties
echo "listener.name.sasl_ssl.scram-sha-512.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username=\"admin\" password=\"admin-secret\";" >> kafka/config/server-1.properties
echo "super.users=User:admin" >> kafka/config/server-1.properties
echo "#Properties for Authorization" >> kafka/config/server-1.properties
echo "authorizer.class.name=kafka.security.authorizer.AclAuthorizer" >> kafka/config/server-1.properties


sed -i 's|/tmp/kafka-logs|/home/user/kafka/data/broker-2|g' kafka/config/server-2.properties
sed -i 's|#listeners=PLAINTEXT://:9092|listeners=SASL_SSL://localhost:9094|g' kafka/config/server-2.properties
sed -i 's|#advertised.listeners=PLAINTEXT://your.host.name:9092|advertised.listeners=SASL_SSL://localhost:9094|g' kafka/config/server-2.properties
sed -i 's|broker.id=0|broker.id=2|g' kafka/config/server-2.properties
sed -i 's|num.partitions=1|num.partitions=2|g' kafka/config/server-2.properties
sed -i 's|zookeeper.connect=localhost:2181|zookeeper.connect=localhost:2182|g' kafka/config/server-2.properties
echo "" >> kafka/config/server-2.properties
echo "" >> kafka/config/server-2.properties
echo "" >> kafka/config/server-2.properties
echo "zookeeper.clientCnxnSocket=org.apache.zookeeper.ClientCnxnSocketNetty" >> kafka/config/server-2.properties
echo "zookeeper.ssl.client.enable=true" >> kafka/config/server-2.properties
echo "zookeeper.ssl.protocol=TLSv1.2" >> kafka/config/server-2.properties
echo "zookeeper.ssl.truststore.location=/home/user/kafka/ssl/kafka.broker2.truststore.jks" >> kafka/config/server-2.properties
echo "zookeeper.ssl.truststore.password=qwerty" >> kafka/config/server-2.properties
echo "zookeeper.ssl.keystore.location=/home/user/kafka/ssl/kafka.broker2.keystore.jks" >> kafka/config/server-2.properties
echo "zookeeper.ssl.keystore.password=asdfgh" >> kafka/config/server-2.properties
echo "zookeeper.set.acl=true" >> kafka/config/server-2.properties
echo "" >> kafka/config/server-2.properties
echo "" >> kafka/config/server-2.properties
echo "ssl.truststore.location=/home/user/kafka/ssl/kafka.broker2.truststore.jks" >> kafka/config/server-2.properties
echo "ssl.truststore.password=qwerty" >> kafka/config/server-2.properties
echo "ssl.keystore.location=/home/user/kafka/ssl/kafka.broker2.keystore.jks" >> kafka/config/server-2.properties
echo "ssl.keystore.password=asdfgh" >> kafka/config/server-2.properties
echo "ssl.key.password=asdfgh" >> kafka/config/server-2.properties
echo "security.inter.broker.protocol=SASL_SSL" >> kafka/config/server-2.properties
echo "ssl.client.auth=required" >> kafka/config/server-2.properties
echo "ssl.protocol=TLSv1.2" >> kafka/config/server-2.properties
echo "" >> kafka/config/server-2.properties
echo "" >> kafka/config/server-2.properties
echo "delete.topic.enable=true" >> kafka/config/server-2.properties
echo "" >> kafka/config/server-2.properties
echo "" >> kafka/config/server-2.properties
echo "#Properties for SASL between a broker and its client" >> kafka/config/server-2.properties
echo "sasl.enabled.mechanisms=SCRAM-SHA-512" >> kafka/config/server-2.properties
echo "sasl.mechanism.inter.broker.protocol=SCRAM-SHA-512" >> kafka/config/server-2.properties
echo "listener.name.sasl_ssl.scram-sha-512.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username=\"admin\" password=\"admin-secret\";" >> kafka/config/server-2.properties
echo "super.users=User:admin" >> kafka/config/server-2.properties
echo "#Properties for Authorization" >> kafka/config/server-2.properties
echo "authorizer.class.name=kafka.security.authorizer.AclAuthorizer" >> kafka/config/server-2.properties


echo "ssl.endpoint.identification.algorithm=https" >> kafka/config/ssl.config
echo "security.protocol=SASL_SSL" >> kafka/config/ssl.config
echo "ssl.keystore.location=/home/user/kafka/ssl/kafka.broker0.keystore.jks" >> kafka/config/ssl.config
echo "ssl.keystore.password=asdfgh" >> kafka/config/ssl.config
echo "ssl.key.password=asdfgh" >> kafka/config/ssl.config
echo "ssl.truststore.location=/home/user/kafka/ssl/kafka.broker0.truststore.jks" >> kafka/config/ssl.config
echo "ssl.truststore.password=qwerty" >> kafka/config/ssl.config
echo "" >> kafka/config/ssl.config
echo "" >> kafka/config/ssl.config
echo "sasl.mechanism=SCRAM-SHA-512" >> kafka/config/ssl.config
echo "sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username=\"admin\" password=\"admin-secret\";" >> kafka/config/ssl.config

sed -i 's|bootstrap.servers=localhost:9092|bootstrap.servers=localhost:9092,localhost:9093|g' kafka/config/producer.properties
echo "security.protocol=SASL_SSL" >> kafka/config/producer.properties
echo "ssl.keystore.location=/home/user/kafka/ssl/kafka.producer.keystore.jks" >> kafka/config/producer.properties
echo "ssl.keystore.password=asdfgh" >> kafka/config/producer.properties
echo "ssl.key.password=asdfgh" >> kafka/config/producer.properties
echo "ssl.truststore.location=/home/user/kafka/ssl/kafka.producer.truststore.jks" >> kafka/config/producer.properties
echo "ssl.truststore.password=qwerty" >> kafka/config/producer.properties
echo "ssl.protocol=TLSv1.2" >> kafka/config/producer.properties
echo "" >> kafka/config/producer.properties
echo "" >> kafka/config/producer.properties
echo "sasl.mechanism=SCRAM-SHA-512" >> kafka/config/producer.properties
echo "sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username=\"my-producer\" password=\"producer-secret\";" >> kafka/config/producer.properties


sed -i 's|group.id=test-consumer-group|group.id=ssl-consumer-group|g' kafka/config/consumer.properties
sed -i 's|bootstrap.servers=localhost:9092|bootstrap.servers=localhost:9092,localhost:9093|g' kafka/config/consumer.properties
echo "security.protocol=SASL_SSL" >> kafka/config/consumer.properties
echo "ssl.keystore.location=/home/user/kafka/ssl/kafka.consumer.keystore.jks" >> kafka/config/consumer.properties
echo "ssl.keystore.password=asdfgh" >> kafka/config/consumer.properties
echo "ssl.key.password=asdfgh" >> kafka/config/consumer.properties
echo "ssl.truststore.location=/home/user/kafka/ssl/kafka.consumer.truststore.jks" >> kafka/config/consumer.properties
echo "ssl.truststore.password=qwerty" >> kafka/config/consumer.properties
echo "ssl.protocol=TLSv1.2" >> kafka/config/consumer.properties
echo "" >> kafka/config/consumer.properties
echo "" >> kafka/config/consumer.properties
echo "sasl.mechanism=SCRAM-SHA-512" >> kafka/config/consumer.properties
echo "sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username=\"my-consumer\" password=\"consumer-secret\";" >> kafka/config/consumer.properties



echo "plugin.path=/home/user/kafka/conns" >> kafka/config/connect-distributed.properties

echo "security.protocol=SASL_SSL" >> kafka/config/connect-distributed.properties 
echo "ssl.keystore.location=/home/user/kafka/ssl/kafka.broker0.keystore.jks" >> kafka/config/connect-distributed.properties
echo "ssl.keystore.password=asdfgh" >> kafka/config/connect-distributed.properties
echo "ssl.key.password=asdfgh" >> kafka/config/connect-distributed.properties
echo "ssl.truststore.location=/home/user/kafka/ssl/kafka.broker0.truststore.jks" >> kafka/config/connect-distributed.properties
echo "ssl.truststore.password=qwerty" >> kafka/config/connect-distributed.properties
echo "#ssl.endpoint.identification.algorithm=https" >> kafka/config/connect-distributed.properties
echo "" >> kafka/config/connect-distributed.properties
echo "" >> kafka/config/connect-distributed.properties
echo "sasl.mechanism=SCRAM-SHA-512" >> kafka/config/connect-distributed.properties
echo "sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username=\"admin\" password=\"admin-secret\";" >> kafka/config/connect-distributed.properties

echo "" >> kafka/config/connect-distributed.properties
echo "" >> kafka/config/connect-distributed.properties
echo "## SSL Properties for Producer app" >> kafka/config/connect-distributed.properties
echo "producer.ssl.truststore.location=/home/user/kafka/ssl/kafka.producer.truststore.jks" >> kafka/config/connect-distributed.properties
echo "producer.ssl.truststore.password=qwerty" >> kafka/config/connect-distributed.properties
echo "producer.security.protocol=SASL_SSL" >> kafka/config/connect-distributed.properties
echo "producer.ssl.keystore.location=/home/user/kafka/ssl/kafka.producer.keystore.jks" >> kafka/config/connect-distributed.properties
echo "producer.ssl.keystore.password=asdfgh" >> kafka/config/connect-distributed.properties
echo "producer.ssl.key.password=asdfgh" >> kafka/config/connect-distributed.properties
echo "producer.sasl.mechanism=SCRAM-SHA-512" >> kafka/config/connect-distributed.properties
echo "producer.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username=\"my-producer\" password=\"producer-secret\";" >> kafka/config/connect-distributed.properties
echo "" >> kafka/config/connect-distributed.properties
echo "" >> kafka/config/connect-distributed.properties
echo "## SSL Properties for Consumer app" >> kafka/config/connect-distributed.properties
echo "consumer.ssl.truststore.location=/home/user/kafka/ssl/kafka.consumer.truststore.jks" >> kafka/config/connect-distributed.properties
echo "consumer.ssl.truststore.password=qwerty" >> kafka/config/connect-distributed.properties
echo "consumer.security.protocol=SASL_SSL" >> kafka/config/connect-distributed.properties
echo "consumer.ssl.keystore.location=/home/user/kafka/ssl/kafka.consumer.keystore.jks" >> kafka/config/connect-distributed.properties
echo "consumer.ssl.keystore.password=asdfgh" >> kafka/config/connect-distributed.properties
echo "consumer.ssl.key.password=asdfgh" >> kafka/config/connect-distributed.properties
echo "consumer.sasl.mechanism=SCRAM-SHA-512" >> kafka/config/connect-distributed.properties
echo "consumer.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username=\"my-consumer\" password=\"consumer-secret\";" >> kafka/config/connect-distributed.properties

