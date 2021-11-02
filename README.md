# README

## Installation

### Requirements

- :gem: Ruby version `2.7.2` (manage Ruby versions with [rvm](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv))
- :elephant: PostgreSQL

### Getting started

- Fork & clone the repository
- `bundle install`
- Run `rails db:create db:migrate`
- Run `bundle exec rspec` to validate the installation
- Run `rails server`
- You're good to go :tada:

## Challenge

See [`doc/challenge/README.md`](./doc/challenge/README.md)

______

## Solution

### OpenAPI UI
\<OpenAPI UI IMAGE HERE\>

### Schema
\<SCHEMA IMAGE HERE\>

### Features:
- Versioned gems
  - All gems have MAJOR and MINOR versions spcecified
    - This way we don't automatically pull breaking changes on `bundle update`
- Versioned API
  - Semantic versioning with MAJOR and MINOR versions specified for endpoints
    - PATCH not specified because user doesn't need to specify version for bug fixes. They can assume that theses happen in the background.
  - Read more about semantic versioning [here](https://semver.org/)
- [OpenAPI](https://swagger.io/specification/) compliant endpoints
  - All API endpoits have OpenAPI specs
  - UI viewable at http://localhost:3000/api-docs
  - YAML file viewable at `swagger/v1.0/swagger.yaml`
  - If change any specs (at `spec/requests`), make sure you run `rails rswag:specs:swaggerize ` after
  - To generate a controller spec file, run `rails generate rspec:swagger API::v1.0::MyController` (replacing `MyController` with the target controller name)
- Integration tests
  - All API endpoints have integration tests
- Dockerized app

### Added Gems:
- `rswag`
- `rails-erd`
- `database_cleaner-active_record`

### Assumptions:
- All transactions are done in a single currency

