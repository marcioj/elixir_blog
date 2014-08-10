# Blog

To start your new Phoenix application you have to:

1. Install dependencies with `mix deps.get`
2. mix ecto.create Repo
3. mix ecto.migrate Repo
4. Start Phoenix router with `mix phoenix.start`

Now you can visit `localhost:4000` from your browser.

## Running tests

1. MIX_ENV=test mix ecto.create Repo
2. MIX_ENV=test mix ecto.migrate Repo
3. mix test

## Notes

* If you choose to change the application's structure, you could manually start the router from your code like this `Blog.Router.start`
