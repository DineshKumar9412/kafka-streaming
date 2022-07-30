#!/bin/bash


sed -i 's|listeners=SSL://localhost:9092|listeners=SASL_SSL://localhost:9092|g' kafka/config/server.properties
sed -i 's|advertised.listeners=SSL://localhost:9092|advertised.listeners=SASL_SSL://localhost:9092|g' kafka/config/server.properties
sed -i 's|security.inter.broker.protocol=SSL|security.inter.broker.protocol=SASL_SSL|g' kafka/config/server.properties
sed -i 's|ssl.client.auth=required|ssl.client.auth=none|g' kafka/config/server.properties
echo "" >> kafka/config/server.properties
echo "" >> kafka/config/server.properties
echo "#Properties for SASL between a broker and its client" >> kafka/config/server.properties
echo "sasl.enabled.mechanisms=SCRAM-SHA-512" >> kafka/config/server.properties
echo "sasl.mechanism.inter.broker.protocol=SCRAM-SHA-512" >> kafka/config/server.properties
echo "listener.name.sasl_ssl.scram-sha-512.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username=\"admin\" password=\"admin-secret\";" >> kafka/config/server.properties
echo "super.users=User:admin" >> kafka/config/server.properties
echo "#Properties for Authorization" >> kafka/config/server.properties
echo "authorizer.class.name=kafka.security.authorizer.AclAuthorizer" >> kafka/config/server.properties


sed -i 's|listeners=SSL://localhost:9093|listeners=SASL_SSL://localhost:9093|g' kafka/config/server-1.properties
sed -i 's|advertised.listeners=SSL://localhost:9093|advertised.listeners=SASL_SSL://localhost:9093|g' kafka/config/server-1.properties
sed -i 's|security.inter.broker.protocol=SSL|security.inter.broker.protocol=SASL_SSL|g' kafka/config/server.properties
sed -i 's|ssl.client.auth=required|ssl.client.auth=none|g' kafka/config/server.properties
echo "" >> kafka/config/server-1.properties
echo "" >> kafka/config/server-1.properties
echo "#Properties for SASL between a broker and its client" >> kafka/config/server-1.properties
echo "sasl.enabled.mechanisms=SCRAM-SHA-512" >> kafka/config/server-1.properties
echo "sasl.mechanism.inter.broker.protocol=SCRAM-SHA-512" >> kafka/config/server-1.properties
echo "listener.name.sasl_ssl.scram-sha-512.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username=\"admin\" password=\"admin-secret\";" >> kafka/config/server-1.properties
echo "super.users=User:admin" >> kafka/config/server-1.properties
echo "#Properties for Authorization" >> kafka/config/server-1.properties
echo "authorizer.class.name=kafka.security.authorizer.AclAuthorizer" >> kafka/config/server-1.properties


sed -i 's|#listeners=PLAINTEXT://:9092|listeners=SASL_SSL://localhost:9094|g' kafka/config/server-2.properties
sed -i 's|#advertised.listeners=PLAINTEXT://your.host.name:9092|advertised.listeners=SASL_SSL://localhost:9094|g' kafka/config/server-2.properties
sed -i 's|security.inter.broker.protocol=SSL|security.inter.broker.protocol=SASL_SSL|g' kafka/config/server-2.properties
sed -i 's|ssl.client.auth=required|ssl.client.auth=none|g' kafka/config/server-2.properties
echo "" >> kafka/config/server-2.properties
echo "" >> kafka/config/server-2.properties
echo "#Properties for SASL between a broker and its client" >> kafka/config/server-2.properties
echo "sasl.enabled.mechanisms=SCRAM-SHA-512" >> kafka/config/server-2.properties
echo "sasl.mechanism.inter.broker.protocol=SCRAM-SHA-512" >> kafka/config/server-2.properties
echo "listener.name.sasl_ssl.scram-sha-512.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username=\"admin\" password=\"admin-secret\";" >> kafka/config/server-2.properties
echo "super.users=User:admin" >> kafka/config/server-2.properties
echo "#Properties for Authorization" >> kafka/config/server-2.properties
echo "authorizer.class.name=kafka.security.authorizer.AclAuthorizer" >> kafka/config/server-2.properties

sed -i 's|security.protocol=SSL|security.protocol=SASL_SSL|g' kafka/config/ssl.config
echo "" >> kafka/config/ssl.config
echo "" >> kafka/config/ssl.config
echo "sasl.mechanism=SCRAM-SHA-512" >> kafka/config/ssl.config
echo "sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username=\"admin\" password=\"admin-secret\";" >> kafka/config/ssl.config

sed -i 's|security.protocol=SSL|security.protocol=SASL_SSL|g' kafka/config/producer.properties
echo "" >> kafka/config/producer.properties
echo "" >> kafka/config/producer.properties
echo "sasl.mechanism=SCRAM-SHA-512" >> kafka/config/producer.properties
echo "sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username=\"my-producer\" password=\"producer-secret\";" >> kafka/config/producer.properties

sed -i 's|security.protocol=SSL|security.protocol=SASL_SSL|g' kafka/config/consumer.properties
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

