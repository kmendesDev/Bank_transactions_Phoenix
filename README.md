* # BananaBank

API that creates an internal system of financial transactions 


* ## Terminal commands used:
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

* ## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

* ## Comandos Github:
Push to other branch:
git checkout -b nome-da-nova-branch     # Cria e troca para o novo branch
git add .                               # Adiciona as modificações
git commit -m "Descrição das modificações"  # Faz o commit
git push origin nome-da-nova-branch     # Envia para o repositório remoto

Merge with branch "Main" : 
git checkout main               # Muda para a branch main
git pull origin main             # Atualiza a main com as últimas mudanças remotas
git merge nome-da-nova-branch   # Faz o merge da sua branch de trabalho na main
git push origin main             # Envia as alterações para o repositório remoto

Cancel the last commit, but keep the changes: git reset --soft HEAD~1
Cancel the last commit and erasing the changes: git reset --hard HEAD~1
Cancel git add: git reset

* maneiras de tratar erros:

  defp handle_response({:ok, user},conn) do
    conn
    |> put_status(:created)
    |> render(:create, user: user)
  end

  defp handle_response({:error, changeset},conn) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: BananaBankWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end

  * Teste do ViaCep:
  {
  "cep": "71015-082",
  "logradouro": "Quadra QI 16 Bloco H",
  "complemento": "",
  "unidade": "",
  "bairro": "Guará I",
  "localidade": "Brasília",
  "uf": "DF",
  "estado": "Distrito Federal",
  "regiao": "Centro-Oeste",
  "ibge": "5300108",
  "gia": "",
  "ddd": "61",
  "siafi": "9701"
}

* Teste create user:
params = %{
	"name" => "Kaioshow",
	"email" => "joao@teste.com",
	"cep" => "12",
	"password" => "1234"
}

* Creating table with migration
mix ecto.gen.migration add_accounts_table
Após criar o banco:
mix ecto.migrate ou mix ecto.reset