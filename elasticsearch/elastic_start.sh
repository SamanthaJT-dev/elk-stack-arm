#!/bin/bash

source /elastic_env.sh

mkdir -p "${ES_LOG_DIR}"
mkdir -p "${ES_DATA_DIR}"
mkdir -p "${ES_TMP_DIR}"

cat /usr/share/elasticsearch/es_start.sh

echo starting elasticsearch
/usr/share/elasticsearch/es_start.sh
echo this is the end
