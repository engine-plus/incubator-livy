ARG SPARK_BASE=818539432014.dkr.ecr.us-east-1.amazonaws.com/engineplus/spark-dev:starlake-v3.0.1-v4

### Final Container
FROM $SPARK_BASE

ARG LIVY_VERSION_ARG=0.7.0-incubating

ENV BASE_IMAGE              $SPARK_BASE#$BASE_IMAGE

ENV LIVY_VERSION            $LIVY_VERSION_ARG
ENV LIVY_HOME               /opt/livy
ENV LIVY_CONF_DIR           $LIVY_HOME/conf

ENV PATH                    $PATH:$LIVY_HOME/bin

# install livy
COPY ./apache-livy-${LIVY_VERSION}-bin.zip /
USER root
RUN apt-get update && \
    apt-get install -y unzip && \
    unzip /apache-livy-${LIVY_VERSION}-bin.zip -d / && \
    mv /apache-livy-${LIVY_VERSION}-bin /opt/ && \
    rm -rf $LIVY_HOME && \
    ln -s /opt/apache-livy-${LIVY_VERSION}-bin $LIVY_HOME && \
    rm -f /apache-livy-${LIVY_VERSION}-bin.zip && \
	rm -f ./apache-livy-${LIVY_VERSION}-bin.zip
USER ${spark_uid}

COPY Dockerfile /my_docker/

#  4040 - Spark UI port
#  7078 - Driver RPC port
#  7079 - Blockmanager port
#  8088 - JMX Exporter for Prometheus
# 10000 - Livy RPC Server for Jupyter integration
EXPOSE 4040 7078 7079 8088 10000