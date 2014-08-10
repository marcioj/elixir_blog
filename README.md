# Blog

To start your new Phoenix application you have to:

1. Install dependencies with `mix deps.get`
2. Create the development database with `mix ecto.create Repo`
3. Create the development database tables with `mix ecto.migrate Repo`
4. Start Phoenix router with `mix phoenix.start`

Now you can visit `localhost:4000` from your browser.

## Running tests

1. Create the test database with `MIX_ENV=test mix ecto.create Repo`
2. Create the test database tables with `MIX_ENV=test mix ecto.migrate Repo`
3. Run the tests with `mix test`

## Notes

* If you choose to change the application's structure, you could manually start the router from your code like this `Blog.Router.start`
