defmodule BananaBank.Users.Create do
  alias BananaBank.Repo
  alias BananaBank.Users.User

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, user}), do: {:ok, user}
  defp handle_insert({:error, changeset}), do: {:error, changeset}
end
