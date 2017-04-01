#!/bin/bash

if [ -z "$SERVER" ]; then
    export SERVER='readthedocs.com'
fi

ALREADY_CONFIGURED=`ls /opt/readthedocs.org/ini | grep configured.ok`
if [ -z $ALREADY_CONFIGURED ]; then

    source /etc/sysconfig/elasticsearch && /usr/share/elasticsearch/bin/elasticsearch -d -p /var/run/elasticsearch/elasticsearch.pid -Des.default.config=$CONF_FILE -Des.default.path.home=$ES_HOME -Des.default.path.logs=$LOG_DIR -Des.default.path.data=$DATA_DIR -Des.default.path.work=$WORK_DIR -Des.default.path.conf=$CONF_DIR

    su - postgres -c '/usr/bin/pg_ctl start -D /var/lib/pgsql/data -s -o "-p 5432" -w -t 300'
    /tmp/configure.sh
    su - postgres -c '/usr/bin/pg_ctl stop -D /var/lib/pgsql/data -s -o "-p 5432" -w -t 300'

    kill -9 `pgrep -f elasticsearch`
    rm -rf /var/run/elasticsearch/elasticsearch.pid
    chown -R elasticsearch:elasticsearch /var/lib/elasticsearch/

    echo 'OK' > /opt/readthedocs.org/ini/configured.ok

fi

# replaces ${SERVER} with host IP
envsubst < /opt/readthedocs.org/ini/nginx.conf.tpl > /opt/readthedocs.org/ini/nginx.conf

exec /usr/bin/supervisord
