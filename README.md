# BananaBank

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Terminal commands used:
  * mix archive.install hex phx_new - Install phoenix
  * brew install postgresql@17 - Install postgresql version 17
  * mix phx.new banana_bank --no-assets --no-html --no-mailer --no-gettext - creates a new phoenix project with no assets, no html views, no swoosh mail files and no gettext files(used when we use more than one language at the project)
  * mix ecto.setup - Creates the dbs 
  * mix ecto.reset - resets the dbs 
  * mix phx.server - turns on the server 
  * mix ecto.gen.migration add_users_table.exs - migrates de dbs and defines the order of the alterations of the dbs
  * Acessing the dbs: 
    * psql -U postgres -d banana_bank_dev / psql -U seu_usuario -d seu_banco_de_dados -h localhost
      * Now you can use the sql commands
    * \dt - tables list 
    * select * from users LIMIT 10; - example of select 
    * \q - quit the psql

  * mix deps.get - baixa bibliotecas adicionadas na deps no mix.exs
BananaBank.Users.User.changeset(%{name: "Kaio", password: "1234", email: "rafael@email.com", cep: "12345123"})

alias BananaBank.Repo
alias BananaBank.Users.User
Repo.insert(%{list}) 
Repo.get(User,1) / BananaBank.Repo.get(BananaBank.Users.User,1)

* Criptografia da password usando Argon2:

  defp add_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    password_hash = Argon2.hash_pwd_salt(password)
    change(changeset, %{password_hash: password_hash})
  end