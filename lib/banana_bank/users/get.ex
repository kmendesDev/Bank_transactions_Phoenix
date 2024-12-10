defmodule BananaBank.Users.Get do
  alias BananaBank.Repo
  alias BananaBank.Users.User

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

end
