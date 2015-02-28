# Uplifting Lemma

Uplifting Lemma is a website composed of several sub-apps. Apps are implemented as isolated Rails engines, and the main app exists solely to handle logins and give a unified presentation.

## Installation

Uplifting Lemma depends on a PostgreSQL database, which it will configure. The first step is to check out the site. Update `config/db.yml` to reflect your database setup. Then run

```ShellSession
$ bundle install
$ bundle exec rake db:migrate
$ bundle exec rake db:setup
```

## Deployment

For development and testing, Uplifting Lemma comes with support for containers via Docker and Fig. Both are in most common package managers (tested with homebrew and yum). To set up the containers, run

```ShellSession
$ ./project.sh bootstrap
```

This will create the necessary data containers using `docker`, then the app's containers using `fig`. To start the containers, run the following *from the project root*

```ShellSession
$ ./project.sh start
```

This will start the app and a PostgreSQL database container. The current directory will be mounted in the app container (which is why the command must be run in the project root), so changes to the project will be picked up. At this point, you have a container listening on port 3000 *internally*, but the port is not mapped outside the container.

If you are not using `boot2docker` or `docker-machine` to run docker, I recommend using [jwilder/nginx-proxy][1], which will listen on the docker socket and automatically set up proxies. The included `Dockerfile` is set up for this, so the domain `upliftinglemma.dev` will be set up for this app.

[1]: https://github.com/jwilder/nginx-proxy

## Apps and App Engines

Each type of app is implemented as an engine in the `engines` directory. Currently, the app types are

* Uplifting Lemma (i.e. the home page)
* Blog (in progress)

Apps are themed by placing stylesheets with the apps' names in `app/assets/stylesheets/themes`. The stylesheet for the current app is automatically loaded.
