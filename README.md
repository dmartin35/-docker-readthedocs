# readthedocs-docker
Project to run ReadTheDocs server inside a docker container


Build the image
---------------

To create the docker image, execute the following command ``make``

Run the server
--------------

To run the docker image and launch the RTD web server, execute ``make run`` or ``make  start`` (to run in detached mode)

**Note:** docker options are indicated in the env_make file

**Warning:** no data (docs/artefacts) are persistent when stopping the docker container. Volumes must be used to do so.


Persistent Data Storage
-----------------------

In order to keep databases, generated docs & build artifacts, when restarting the container, volumes can be created on the host, through docker.

Three volumes are necessary:
- RTD source code & generated docs/artifacts
- postgresql database
- elasticsearch database

```shell
docker volume create --name rtd
docker volume create --name db
docker volume create --name es
```

Then run the docker image with volumes as arguments: ``docker run -d -p 80:80 -e SERVER=127.0.0.1 -v rtd:/opt/readthedocs.org -v db:/var/lib/pgsql/data -v es:/var/lib/elasticsearch [<namespace>/]rtd:latest``

**Note:** volumes are commented by default in the env_make file, feel free to un-comment and use them.


Limitations
-----------

- only supports svn, git and mercurial
- Email verification on signup has been turned off
- A default admin user is automatically created to be used for slumber API
- subdomains are not tested (not sure it still works after patching doc with full absolute url)
- [bug] links are broken in doc's search result page (contains <filename>.<ext>.html that cannot be found)

Tips
----

- Remove exited containers: ``docker rm $(docker ps -q --filter status=exited)``
- Remove un-tagged images: ``docker rmi $(docker images | grep "^<none>" | awk '{print $3}')``
