defmodule Elixir.BananaBank.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do # O próprio ecto infere como fazer rollback
    create table("users") do
      add :name, :string, null: false
      add :password_hash, :string, null: false
      add :email, :string, null: false
      add :cep, :string, null: false

      timestamps() #Adiciona colunas de tempo da inserção e atualização dos registros
    end
  end
end
