#!/bin/bash



function configure_postgreSQL(){
    psql -U postgres -c "CREATE USER rtd WITH PASSWORD 'rtd'; ALTER USER rtd WITH SUPERUSER;"
    createdb -U postgres --owner rtd readthedoc
}



function configure_django(){
    # create secret_key file
    cat /dev/urandom | tr -dc 'a-zA-Z0-9!#$%^&*(-_=+)' | fold -w 50 | head -n 1  > /opt/readthedocs.org/ini/secret_key.txt

}

function django_admin() {
    # run admin command
    source /opt/venv/rtd/bin/activate
    export DJANGO_SETTINGS_MODULE=readthedocs.settings.prod
    cd /opt/readthedocs.org/
    python manage.py makemigrations
    python manage.py migrate
    echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@readthedocs.locahost.com', 'azerty1234')" | python manage.py shell
    python manage.py collectstatic --noinput
    deactivate
}


function configure_elesticsearch(){

    source /opt/venv/rtd/bin/activate
    export PYTHONPATH=/opt/readthedocs.org/
    export DJANGO_SETTINGS_MODULE=readthedocs.settings.prod
    python /tmp/configure_elasticsearch.py
    deactivate

}


function configure_rtd_folders(){

    for folder in media private_cname_project private_cname_root private_web_root public_cname_project public_cname_root public_web_root user_builds
    do
        mkdir -p /opt/readthedocs.org/$folder
    done

}


configure_postgreSQL
configure_django
django_admin
configure_elesticsearch
configure_rtd_folders

