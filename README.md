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

@todo - run with volumes on host, for database, docs & artefacts to be stored on host for persistent data storage


Limitations
-----------

- only supports svn, git and mercurial
- Email verification on signup has been turned off
- A default admin user is automatically created to be used for slumber API
- subdomains are not tested (not sure it still works after patching doc with full absolute url)
- [bug] links are broken in doc's search result page (contains <filename>.<ext>.html that cannot be found)