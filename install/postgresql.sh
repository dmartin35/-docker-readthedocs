#!/bin/bash

yum install -y postgresql-devel
yum install -y  postgresql postgresql-server postgresql-contrib
su - postgres -c "initdb --auth-host=md5"
