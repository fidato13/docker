# Pull base image.
FROM fidato/ubuntu-java:latest

# install hadoop 2.7.3
RUN wget http://mirror.fibergrid.in/apache/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz && \
    tar -xzvf hadoop-2.7.3.tar.gz && \
    mv hadoop-2.7.3 /usr/local/hadoop && \
    rm hadoop-2.7.3.tar.gz

# set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
ENV HADOOP_HOME=/usr/local/hadoop 
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin 
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV YARN_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
ENV HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib"

#add hadoop user group and user
USER root

RUN mkdir -p /root/hdfs/namenode && \ 
    mkdir -p /root/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs

#copy hadoop configs
COPY hadoop_configs/core-site.xml /usr/local/hadoop/etc/hadoop/.
COPY hadoop_configs/hdfs-site.xml /usr/local/hadoop/etc/hadoop/.
COPY hadoop_configs/yarn-site.xml /usr/local/hadoop/etc/hadoop/.
COPY hadoop_configs/mapred-site.xml /usr/local/hadoop/etc/hadoop/.
COPY hadoop_configs/masters /usr/local/hadoop/etc/hadoop/.
COPY hadoop_configs/slaves /usr/local/hadoop/etc/hadoop/.
COPY hadoop_configs/hadoop-env.sh /usr/local/hadoop/etc/hadoop/.

# Define default command.
CMD ["sh", "-c" ,"service ssh restart; bash"]