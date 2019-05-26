Ruby version: 2.6.1

Rails version: 5.2.3

# Install

## Build Docker Image

`docker-compose build`

## Create and Migrate DB

`docker-compose run web rake db:create db:migrate`

# Start Application

`docker-compose up`

# Tests

## Migrate Test DB

`docker-compose run -e "RAILS_ENV=test" web rake db:migrate`

## Run tests

`docker-compose run web rspec`
