#!/bin/bash

function create_venv(){
    cd /tmp
    curl -O https://bootstrap.pypa.io/get-pip.py
    python get-pip.py
    pip install virtualenv
    /usr/bin/virtualenv /opt/venv/rtd
    source /opt/venv/rtd/bin/activate
    pip install -r /opt/readthedocs.org/requirements.txt
    pip install uwsgi
    pip install psycopg2
    deactivate
}

function get_RTD_src() {
    cd /opt/
    git clone https://github.com/rtfd/readthedocs.org.git
    cd /opt/readthedocs.org/
    git checkout 340ea0e55d185aad2a86a76bd81a89ce8be13d51
}

get_RTD_src
create_venv