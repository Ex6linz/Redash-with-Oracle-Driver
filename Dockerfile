FROM redash/redash:8.0.0.b32245

USER root

ADD oracle/instantclient-basic-linux.x64-19.18.0.0.0dbru.zip /tmp/instantclient-basic-linux.x64-19.18.0.0.0dbru.zip
ADD oracle/instantclient-sdk-linux.x64-19.18.0.0.0dbru.zip /tmp/instantclient-sdk-linux.x64-19.18.0.0.0dbru.zip
ADD oracle/instantclient-sqlplus-linux.x64-19.18.0.0.0dbru.zip /tmp/instantclient-sqlplus-linux.x64-19.18.0.0.0dbru.zip

RUN apt-get update  -y
RUN apt-get install -y unzip

RUN unzip /tmp/instantclient-basic-linux.x64-19.18.0.0.0dbru.zip -d /usr/local/
RUN unzip /tmp/instantclient-sdk-linux.x64-19.18.0.0.0dbru.zip -d /usr/local/
RUN unzip /tmp/instantclient-sqlplus-linux.x64-19.18.0.0.0dbru.zip -d /usr/local/
RUN ln -s /usr/local/instantclient_19_18 /usr/local/instantclient
RUN ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus

RUN apt-get install libaio-dev -y
RUN apt-get clean -y

ENV ORACLE_HOME=/usr/local/instantclient
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/instantclient

RUN pip install cx_Oracle==7.0.0

USER redash
#Add REDASH ENV to add Oracle Query Runner
ENV REDASH_ADDITIONAL_QUERY_RUNNERS=redash.query_runner.oracle
