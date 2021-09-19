FROM balenalib/raspberrypi3-debian:latest

ENV ES_VERSION=7.14.1 \
    ES_OS=linux \
    ES_ARCH=aarch64 \
    ES_EXEC=elasticsearch \
    ES_HOST=0.0.0.0 \
    ES_NODE_NAME=elasticsearch \
    ES_DISCOVERY_TYPE=single-node \
    ES_HEAP=2g \
    ES_TRANSPORT_PORT=9300 \
    ES_HTTP_PORT=9200 \
    JAVA_VERSION=11 \
    ES_HOME=/usr/share/elasticsearch

RUN apt-get update && \
  apt-get -qy install bash curl ca-certificates openjdk-$JAVA_VERSION-jdk openjdk-$JAVA_VERSION-jre telnet net-tools

RUN curl -fsSL https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$ES_VERSION-$ES_OS-$ES_ARCH.tar.gz -o elasticsearch.tgz && \
  tar xvzf elasticsearch.tgz > /dev/null 2>&1 && \
  mv elasticsearch-$ES_VERSION $ES_HOME && \
  # echo "-Xlog:disable" >> $ES_HOME/gc.options && \
  rm -rf elasticsearch.tgz

RUN sed -i "s/Xms1g/Xms$ES_HEAP/g;s/Xmx1g/Xmx$ES_HEAP/g" $ES_HOME/config/jvm.options && \
  echo $ES_EXEC -v -E node.name=$ES_NODE_NAME -E cluster.name=$ES_NODE_NAME -E transport.tcp.port=$ES_TRANSPORT_PORT -E transport.host=$ES_HOST -E http.port=$ES_HTTP_PORT -E network.host=$ES_HOST -E discovery.type=$ES_DISCOVERY_TYPE -E xpack.security.enabled=false -E xpack.ml.enabled=false -E xpack.graph.enabled=false -E xpack.monitoring.enabled=false -E xpack.enrich.enabled=false -E xpack.watcher.enabled=false > $ES_HOME/es_start.sh && \
  chmod +x $ES_HOME/es_start.sh

# https://serverfault.com/questions/1037146/docker-container-with-random-date
# RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC 648ACFD622F3D138 \
#  && echo "deb http://deb.debian.org/debian buster-backports main" | sudo tee -a /etc/apt/sources.list.d/buster-backports.list \
#  && sudo apt update \
#  && sudo apt install -t buster-backports libseccomp2 \
#  && sudo apt upgrade -y


COPY ./elastic_env.sh ./elastic_start.sh /

RUN chmod +x /elastic_env.sh && \
  chmod +x /elastic_start.sh

VOLUME [ "/usr/share/elasticsearch/data" ]

EXPOSE 9200 9300

CMD [ "/elastic_start.sh" ]
