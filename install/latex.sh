#!/bin/bash

# http://pj.freefaculty.org/EL/7/x86_64/
yum install -y wget

wget http://pj.freefaculty.org/EL/7/x86_64/texlive-capt-of-svn29803.0-1.1EL7.noarch.rpm http://pj.freefaculty.org/EL/7/x86_64/texlive-needspace-svn29601.1.3d-1.1EL7.noarch.rpm http://pj.freefaculty.org/EL/7/x86_64/texlive-eqparbox-svn29419.4.0-1.1EL7.noarch.rpm http://pj.freefaculty.org/EL/7/x86_64/texlive-environ-svn29600.0.3-1.1EL7.noarch.rpm http://pj.freefaculty.org/EL/7/x86_64/texlive-trimspaces-svn15878.1.1-1.1EL7.noarch.rpm http://pj.freefaculty.org/EL/7/x86_64/texlive-environ-svn29600.0.3-1.1EL7.noarch.rpm http://pj.freefaculty.org/EL/7/x86_64/texlive-eqparbox-svn29419.4.0-1.1EL7.noarch.rpm
wget http://pj.freefaculty.org/EL/7/x86_64/texlive-upquote-svn26059.v1.3-1.1EL7.noarch.rpm
wget http://pj.freefaculty.org/EL/7/x86_64/texlive-tabulary-doc-svn15878.0.9-1.1EL7.noarch.rpm
wget http://pj.freefaculty.org/EL/7/x86_64/texlive-tabulary-svn15878.0.9-1.1EL7.noarch.rpm

yum install -y texlive-pdftex texlive-tetex texlive-latex-bin texlive-makeindex texlive-texconfig texlive-cmap texlive-metafont texlive-fontspec texlive-ec texlive-cm texlive-fancyhdr texlive-fancybox texlive-titlesec texlive-framed texlive-pdftex-def texlive-threeparttable texlive-mdwtools texlive-wrapfig texlive-parskip
yum install -y texlive-pdftex-doc texlive-pdftex texlive-caption
yum install -y texlive-times texlive-helvetic texlive-courier texlive-dvips texlive-misc texlive-multirow
yum install -y texlive-fncychap texlive-ifluatex

rpm -i texlive-upquote-svn26059.v1.3-1.1EL7.noarch.rpm
rpm -i texlive-capt-of-svn29803.0-1.1EL7.noarch.rpm
rpm -i texlive-needspace-svn29601.1.3d-1.1EL7.noarch.rpm
rpm -i texlive-eqparbox-svn29419.4.0-1.1EL7.noarch.rpm
rpm -i texlive-environ-svn29600.0.3-1.1EL7.noarch.rpm
rpm -i texlive-trimspaces-svn15878.1.1-1.1EL7.noarch.rpm
rpm -i texlive-environ-svn29600.0.3-1.1EL7.noarch.rpm
rpm -i texlive-eqparbox-svn29419.4.0-1.1EL7.noarch.rpm
rpm -i texlive-tabulary-svn15878.0.9-1.1EL7.noarch.rpm
rpm -i texlive-tabulary-doc-svn15878.0.9-1.1EL7.noarch.rpm
