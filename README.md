# Booky

Booky is an experimental librarian web app written in Phoenix, to keep track of who took
which books from the office bookshelf.

As all office staff have GitHub accounts, membership in the organization is used to determine
who can login.

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Copy `config/dev.secret-sample.exs` to `config/dev.secret.exs` and fill in the values.
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

The GitHub app asks for permission to read your organizations. This is to determine if you belong
to the configured organization.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
