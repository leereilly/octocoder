![Octocoder](http://i.imgur.com/IEcUy.png "Octocoder")

# About

Octocoder is a simple rack-based web service for use by [Coderwall](http://www.coderwall.com) to identify users' repository-based achievements.

* **Riding the Rails** - user has contributed to the Rails framework.
* **In the Wee Small Hours** - user has contributed to the Sinatra framework.

# Usage

In a nutshell, you'll query `http://octocoder.heroku.com/v2/rails/rails/leereilly` and get the following JSON response indicating that `leereilly` has made 6 contributions to the repository called `rails` owned by user `rails`:
  
    {"count":6}
    
# Examples

* [http://octocoder.heroku.com/rails/rails/dhh](http://octocoder.heroku.com/rails/rails/dhh)
* [http://octocoder.heroku.com/sinatra/sinatra/leereilly](http://octocoder.heroku.com/sinatra/sinatra/leereilly)
* [http://octocoder.heroku.com/mojombo/chronic/leereilly](http://octocoder.heroku.com/mojombo/chronic/leereilly)
* [http://octocoder.heroku.com/imathis/octopress/imathis](http://octocoder.heroku.com/imathis/octopress/imathis)

# Installation

## Local installation

**Prerequisites:**

* RVM
* Bundler

Clone the repository

    git clone git@github.com:leereilly/octocoder.git
    cd octocoder
    
Install bundler and the required gems

    gem install bundler     
    bundle install
    
Set your database environment variable

    mysql://octocoder:super-duper-password@mysql.github.com/octocoder
    
Run the tests

    rake spec
    
If everything looks OK, launch the application

    shotgun    
    
## Installation on Heroku  

There are 4 easy steps (if you've used Heroku before). Please refer to [Heroku Dev Center](http://devcenter.heroku.com/articles/quickstart) for help with Heroku.

    git clone git@github.com:leereilly/octocoder.git
    cd octocoder
    heroku create 
    git push heroku master

# Note About API Version

If you want to always use the **latest** API version, point to `http://octocoder.heroku.com/:owner/:repo/:user`

**NB:** This is usually considered bad practice i.e. if the API changes then your app might crash/burn/kill.

If you want to always hit version 1 of the API (current stable version) hit `http://octocoder.heroku.com/v1/rails/rails/leereilly`

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
* Gems sinatra, mongo-mapper, shotgun, heroku, rest-client, json, rspec, rack-test and webrat

# Bugs / Known Issues

* This is hosted on a free Heroku account with only one dyno i.e. performance and availability not guaranteed.
* The current GitHub API (Version 3) document doesn't list Contributor as an available resource; it may be modified/removed at any time :-o
* More in the issues ^
* The first time a repository is hit, all the contributors are cached. Subsequent calls will be faster.

![Bugs](http://i.imgur.com/K8vsw.gif "Bugs")