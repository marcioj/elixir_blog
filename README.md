# Blog

> A simple CRUD application for learning purposes using phoenix and ecto.

[![Build Status][travis_badge]][travis]

## Installation

1. Clone the repo with `git clone git@github.com:marcioj/elixir_blog.git`
1. `cd elixir_blog`
1. Install dependencies with `mix deps.get`
1. Create the development database with `mix ecto.create Repo`
1. Create the development database tables with `mix ecto.migrate Repo`
1. Start Phoenix router with `mix phoenix.server`

Now you can visit `localhost:4000` from your browser.

## Automatic code reloading

1. Install the `nodejs` package (or your system's equivalent) if you don't have it already
1. Install npm dependencies with `npm install`
1. (Linux Only) Install `inotify-tools` with the package manager of your preference

## Running tests

1. Create the test database with `MIX_ENV=test mix ecto.create Repo`
1. Create the test database tables with `MIX_ENV=test mix ecto.migrate Repo`
1. Run the tests with `mix test`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[travis]: https://travis-ci.org/marcioj/elixir_blog
[travis_badge]: https://api.travis-ci.org/marcioj/elixir_blog.svg?branch=master
