defmodule BananaBankWeb.UsersJSON do

  alias BananaBank.Users.User

  def create(%{user: user}) do
    %{
      message: "User created !",
      data: data(user)
    }
  end
  defp data(%User{} = user) do
    %{
      id: user.id,
      cep: user.cep,
      email: user.email,
      name: user.name
    }
  end
end
