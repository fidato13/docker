# Pull base image.
FROM fidato/ubuntu-java:latest

# install hadoop 2.7.3
RUN wget http://mirror.fibergrid.in/apache/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz && \
    tar -xzvf hadoop-2.7.3.tar.gz && \
    mv hadoop-2.7.3 /usr/local/hadoop && \
    rm hadoop-2.7.3.tar.gz

# set environment variable
ENV HADOOP_HOME=/usr/local/hadoop 
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin 

RUN mkdir -p ~/hdfs/namenode && \ 
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs 

#add hadoop user group and user
USER root
RUN addgroup hadoop
RUN adduser --ingroup hadoop hduser
RUN echo "hduser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

#copy hadoop configs
COPY hadoop_configs/core-site.xml /usr/local/hadoop/etc/hadoop/.
COPY hadoop_configs/hdfs-site.xml /usr/local/hadoop/etc/hadoop/.
COPY hadoop_configs/yarn-site.xml /usr/local/hadoop/etc/hadoop/.
COPY hadoop_configs/mapred-site.xml /usr/local/hadoop/etc/hadoop/.
COPY hadoop_configs/masters /usr/local/hadoop/etc/hadoop/.
COPY hadoop_configs/slaves /usr/local/hadoop/etc/hadoop/.

# Define default command.
CMD ["bash"]