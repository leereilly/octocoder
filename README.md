# About

This is a simple, RESTful, rack-based web service for use by [Coderwall](http://www.coderwall.com). It answers the question "_how many contributions has a particular user made to particular source code repository on GitHub?_". It'll (hopefully) be used to generate thousands of achievements for Coderwall e.g.

* **Riding the Rails** - user has contributed to the Rails framework.
* **In the Wee Small Hours** - user has contributed to the Sinatra framework.

In a nutshell, you'll query `http://coderwall-contributor-service.heroku.com/v1/rails/rails/leereilly` and get the following JSON response indicating that `leereilly` has made 6 contributions to the repository called `rails` owner by user `rails`:

    {"count":6}

# Installation

## Local installation

**Prerequisites:**

* RVM

Clone the repository

    git clone git@github.com:leereilly/coderwall-contributor-service.git
    cd coderwall-contributor-service
    
Install bundler and the required gems

    gem install bundler     
    bundle install
    
Run the tests

    rake spec
    
If everything looks OK, launch the application

    shotgun    
    
## Installation on Heroku  

There are 4 easy steps (if you've used Heroku before). Please refer to [Heroku Dev Center](http://devcenter.heroku.com/articles/quickstart) for help with Heroku.

    git clone git@github.com:leereilly/coderwall-contributor-service.git
    cd coderwall-contributor-service
    heroku create 
    git push heroku master

# Usage

Call `http://coderwall-contributor-service.heroku.com/:owner/:repo/:user` e.g.

    curl http://coderwall-contributor-service.heroku.com/v1/rails/rails/leereilly
    {"count":6}
    
## Note About API Version

If you want to always use the **latest** API version, point to `http://coderwall-contributor-service.heroku.com/:owner/:repo/:user`

**NB:** This is usually considered bad practice i.e. if the API changes then your app might crash/burn/kill.

If you want to always hit version 1 of the API (current stable version) hit

http://coderwall-contributor-service.heroku.com/v1/rails/rails/leereilly

Version 2 (v2) is coming soon...

## PLZ

Please don't point your uber-impressive **production** apps to the example heroku URL above. It's a free account with limited resources. Thank you!

# Contributing

Contributions are welcome and encouraged! You know the drill. 

* Fork.
* Commit code with tests.
* Pull.

## General guidelines

Any changes to the actual API that aren't backwards-compatible should be added to a new version.

# Kudos

* GitHub for being awesome __and__ having a public API
* Coderwall
* Gems sinatra, shotgun, heroku, rest-client, json, rspec, rack-test and webrat
* The letter 'F'

# Bugs / Known Issues

* The current GitHub API (Version 3) document doesn't list Contributor as an available resource; it may be modified/removed at any time :-o
* Version 1 of the coderwall-contributor-service pings the GitHub API for every single user/repo requested. Version 2 will store a cached copy on the filesystem (hard if I stick with Heroku) or in a database.
* Timeouts/going over the GitHub API limit... version 2 :-)

![Bugs](http://i.imgur.com/K8vsw.gif "Bugs")