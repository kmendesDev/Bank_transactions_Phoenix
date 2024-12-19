defmodule BananaBank.Accounts.Create do
  alias BananaBank.Repo
  alias BananaBank.Accounts.Account

  def call(params) do #Adicionar a condição de não permitir a criação se não houver user criado
      params
      |> Account.changeset()
      |> Repo.insert()
  end
end
