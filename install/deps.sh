#!/bin/bash

yum update -y
yum install -y gcc
yum install -y wget patch
yum install -y svn git mercurial
yum install -y libxml2-devel libxslt-devel
yum install -y python-devel policycoreutils-python
yum install -y openldap-devel


