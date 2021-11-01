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

### Schema
\<SCHEMA IMAGE HERE\>

### Features:
- Versioned gems
  - All gems have MAJOR and MINOR versions spcecified
    - This way we don't automatically pull breaking changes on `bundle update`
- Versioned API
  - Semantic versioning with MAJOR and MINOR versions specified for endpoints
  - PATCH not specified because user doesn't need to specify version for backwards compatible fixes. They can assume that theses happen in the background.
  - Read more about semantic versioning [here](https://semver.org/)
- [OpenAPI](https://swagger.io/specification/) compliant endpoints
  - All API endpoits and models have OpenAPI specs
- Integration tests
  - All API endpoints have integration tests
- Dockerized app
