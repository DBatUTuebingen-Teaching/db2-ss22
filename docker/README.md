
(#) Docker Installation

1. First you have to install the _Docker Engine_, which is available on Linux, macOS, and Windows 10.

  For instructions, checkout: https://docs.docker.com/engine/install/

  For macOS, and Windows 10, install the Docker Desktop App.

2. Install Docker-Compose

  If you are Linux based, you have to install Docker-Compose separately.

  Instructions can be found here: https://docs.docker.com/compose/install/


3. Check your installation.
  
  Once you have completed the installation steps, open a terminal session and make sure that your installation of docker works:

  ~~~none
  ❯ docker --version
  Docker version 19.03.8, build afacb8b

  ❯ docker-compose --version
  docker-compose version 1.25.4, build 8d51620a
  ~~~

(#) Setup Postgres

If everything is installed correctly, open a terminal session and change directory to where the docker-compose.yml file is located.

To start the database systems PostgreSQL12 and MonetDB use `docker-compose up -d`. This command will download all docker images from http://dockerhub.com and run everything deamonised (which means, that it will run in the background until you stop it!).

⚠ To stop the services use `docker-compose down` or `docker-compose down -v` IFF you want to delete all database files as well.

(##) Create a new user

To get things started, create a new user and a database. Make sure the PostgreSQL server is running before you start. Use `docker-compose ps -a` to do so.

In order to connect to the database system we do not have to install any packages locally, everything required comes bundled with the docker image.

Running `docker exec -it pg12 psql -U postgres -d postgres` opens a psql session inside the docker container.

To create a new user insert: 
~~~
CREATE ROLE root SUPERUSER CREATEDB INHERIT LOGIN;
CREATE DATABASE root;
\q
~~~

You can now use `docker exec -it psql` without the `-U` and `-d` flags.
