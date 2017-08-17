{code}の人 Control Panel
========================

CP is an application for manage small team.
CP collect information about projects, time spent and spent or earned money.
CP gives you statistic based on collected data.

Application made with Ruby on Rails, PostgreSQL by
[{code}の人 team](http://codenohito.ru/).


Getting started
---------------

Make sure you have Ruby version installed, specified in the `.ruby-version`
file in the root directory of the application.

If you use [RVM](https://rvm.io/) add a '.ruby-gemset'
[file](https://rvm.io/workflow/projects#project-file-ruby-version)
to the root directory of the application.

The application uses PostgreSQL. Versions 8.2 and up are supported.
Create database and config file `config/database.yml` for connection.
File example:

    development:
      adapter: postgresql
      database: cnhcp_dev
      pool: 5

Create `config/cable.yml` file:

    development:
      adapter: async

Create `config/secrets.yml` file:

    development:
      secret_key_base: 49e51e4cfef2252ccfb3b4501cfe3ec496aa5d06a631195b9f594088b1244d2072943398cc40afee6141a827567e0ed4b4ef4de7f2ff5ade163225122879fcee

When done, run:

    $ bin/bundle install --without production
    $ bin/rails db:create db:migrate

Install demo data using command: `bin/rails db:seed` if you need.

Application ready for start. You can launch webserver with
command `bin/rails server` and see home page
at [localhost:3000](http://localhost:3000/) url.


Deployment
----------

You need access to the production server to perform a deploy.

Run a deploy with command `mina deploy`.

Before the first deploy to server you'll need to run `mina setup`
for production. Also you'll need to create files 'application.yml', 'cable.yml'
and 'secrets.yml' in 'shared/config' directory on the server.

API documentation
-----------------

__GET__ `/projects.json` &mdash; Get list of projects.
<br>Params: none
<br>Return:

    {
      "projects":[
        {"id":4,"title":"Svezhov Dev"},
        {"id":3,"title":"Svezhov TR"},
        {"id":2,"title":"Codenohito CP"},
        {"id":1,"title":"Codenohito Growth"}
      ]
    }
