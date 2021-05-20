ARG SPARK_BASE=818539432014.dkr.ecr.us-east-1.amazonaws.com/engineplus/spark-dev:livy-spark-v7

FROM $SPARK_BASE

ENV BASE_IMAGE	$SPARK_BASE#$BASE_IMAGE

RUN cp $LIVY_CONF_DIR/log4j.properties.template $LIVY_CONF_DIR/log4j.properties && \
    mkdir -p $LIVY_HOME/work-dir && \
    mkdir /var/log/livy && \
    ln -s /var/log/livy $LIVY_HOME/logs

COPY conf/* $LIVY_CONF_DIR/
COPY entrypoint.sh /opt/
COPY Dockerfile /my_docker/

RUN chmod 777 /opt/entrypoint.sh

#  8998 - Livy Server port
# 10000 - Livy RPC Server for Jupyter integration
EXPOSE 8998 10000

WORKDIR $LIVY_HOME/work-dir

ENTRYPOINT [ "/opt/entrypoint.sh" ]