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
RUN addgroup hadoop
RUN useradd -ms /bin/bash hduser -g hadoop
#RUN adduser --ingroup hadoop hduser
RUN echo "hduser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

#Create log directory
RUN mkdir $HADOOP_HOME/logs

#Change ownership to hduser so that log file location can be created
RUN chown -R hduser:hadoop /usr/local/hadoop
RUN chown -R hduser:hadoop /root

#switch user to hduser
USER hduser
WORKDIR /home/hduser

RUN mkdir -p /home/hduser/hdfs/namenode && \ 
    mkdir -p /home/hduser/hdfs/datanode

#copy hadoop configs
COPY hadoop_configs/core-site.xml /usr/local/hadoop/etc/hadoop/.
COPY hadoop_configs/hdfs-site.xml /usr/local/hadoop/etc/hadoop/.
COPY hadoop_configs/yarn-site.xml /usr/local/hadoop/etc/hadoop/.
COPY hadoop_configs/mapred-site.xml /usr/local/hadoop/etc/hadoop/.
COPY hadoop_configs/masters /usr/local/hadoop/etc/hadoop/.
COPY hadoop_configs/slaves /usr/local/hadoop/etc/hadoop/.



# Define default command.
CMD ["bash"]