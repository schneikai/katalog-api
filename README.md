# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...

## Documentation

Improved YARD CHEATSHEET http://yardoc.org
https://gist.github.com/phansch/db18a595d2f5f1ef16646af72fe1fb0e

Yard tags reference
https://www.rubydoc.info/gems/yard/file/docs/Tags.md

Rails API documentation guidelines
https://guides.rubyonrails.org/api_documentation_guidelines.html

https://everydayrails.com/2017/03/01/rails-5-app-documentation.html

## Ruby 3 Bug

I was using Ruby 3 but this would print huge error message in test failures and made testing impossible.
I found a few similar bug reports on Google but no solutions. Going with Ruby 2 for now.

## Monkeypatches

### Warden Devise JWT Sessions Patch

This patch that prevents devise from returning a user from the session if token auth is used
https://stackoverflow.com/questions/63529743/rails-devise-jwt-session-storage
https://blog.siliconjungles.io/devise-jwt-with-sessions-hybrid

Patch Location

    config/initializers/warden/proxy.rb

## Application secrets

### Edit Secrets

    EDITOR="code --wait" bundle exec rails credentials:edit

### Use Secrets

    Rails.application.credentials.secret_key_base

## Debugger

### Open Debugger

    binding.break
