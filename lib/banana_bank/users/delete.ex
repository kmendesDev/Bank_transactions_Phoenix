defmodule BananaBank.Users.Delete do
  alias BananaBank.Repo
  alias BananaBank.Users.User

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> Repo.delete(user)
    end
  end
end
