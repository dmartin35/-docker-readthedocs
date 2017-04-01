FROM centos:centos7.2.1511
LABEL maintainer "https://github.com/dmartin35"
LABEL name "ReadTheDocs"

RUN yum -y update
RUN yum -y install python-setuptools
RUN easy_install supervisor
# install gettext for envsubst cmd
RUN yum -y install gettext
RUN yum -y install psmisc

# exec main install scripts
ADD install /tmp/install
RUN chmod +x /tmp/install/*.sh
RUN /bin/bash /tmp/install/deps.sh
RUN /bin/bash /tmp/install/postgresql.sh
RUN /bin/bash /tmp/install/nginx.sh
RUN /bin/bash /tmp/install/elastic.sh
RUN /bin/bash /tmp/install/redis.sh
RUN /bin/bash /tmp/install/latex.sh

# RTD - source & venv & configure
RUN /bin/bash /tmp/install/rtd.sh
RUN mkdir -p /opt/readthedocs.org/ini
COPY resources/rtd/conf.py.tmpl.patch /opt/readthedocs.org/ini/conf.py.tmpl.patch
RUN cd /opt/readthedocs.org && patch -p1 < /opt/readthedocs.org/ini/conf.py.tmpl.patch
COPY resources/rtd/settings/prod.py /opt/readthedocs.org/readthedocs/settings/prod.py
RUN chmod 644 /opt/readthedocs.org/readthedocs/settings/prod.py
# apply patch - fixing https://github.com/rtfd/readthedocs.org/issues/2261 for firefox
COPY resources/rtd/details.css.patch /opt/readthedocs.org/ini/details.css.patch
RUN cd /opt/readthedocs.org && patch -p1 < /opt/readthedocs.org/ini/details.css.patch

#LOGROTATE
COPY resources/logrotate.d/celery /etc/logrotate.d/celery
COPY resources/logrotate.d/uwsgi /etc/logrotate.d/uwsgi
COPY resources/logrotate.d/elasticsearch /etc/logrotate.d/elasticsearch
COPY resources/logrotate.d/nginx /etc/logrotate.d/nginx
COPY resources/logrotate.d/redis /etc/logrotate.d/redis
COPY resources/logrotate.d/rtd /etc/logrotate.d/rtd

#CELERY
RUN mkdir -p /etc/conf.d/
COPY resources/celery.conf /etc/conf.d/celery
RUN mkdir -p /var/log/celery
RUN mkdir -p /var/run/celery

#UWSGI
COPY resources/uwsgi.ini /opt/readthedocs.org/ini/uwsgi.ini
RUN mkdir -p /var/log/uwsgi/
RUN mkdir -p /etc/uwsgi/vassals/
RUN ln -s /opt/readthedocs.org/ini/uwsgi.ini /etc/uwsgi/vassals/

#NGINX
RUN mkdir /run/nginx && chown nginx:nginx /run/nginx
COPY resources/nginx_default.conf /etc/nginx/nginx.conf
COPY resources/nginx_rtd.conf /opt/readthedocs.org/ini/nginx.conf.tpl
RUN ln -s /opt/readthedocs.org/ini/nginx.conf /etc/nginx/conf.d/

#ELASTICSEARCH
COPY resources/configure_elasticsearch.py /tmp/configure_elasticsearch.py

# configure script
COPY configure.sh /tmp/configure.sh
RUN chmod +x /tmp/configure.sh

EXPOSE 80 9001

COPY supervisord.conf /etc/supervisord.conf
ADD entry_point.sh /entry_point.sh
RUN chmod -v +x /entry_point.sh
CMD ["/entry_point.sh"]

