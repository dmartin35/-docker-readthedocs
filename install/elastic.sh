#!/bin/bash

cd /tmp
yum install -y java
wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.5.2.noarch.rpm
rpm -ivh elasticsearch-1.5.2.noarch.rpm
/usr/share/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-icu/2.5.0
