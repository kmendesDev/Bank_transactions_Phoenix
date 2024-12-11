defmodule BananaBankWeb.UsersController do
  use BananaBankWeb, :controller

  alias BananaBank.Users
  alias Users.User

  # Toda vez que der erro, vai pro FallbackController
  action_fallback BananaBankWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create(params) do  # Pattern matching
      conn
      |> put_status(:created)
      |> render(:create, user: user)
    end
  end
  def show(conn, %{"id" => id}) do  #Usando get, coloca string "id" ao invés de átomo
    with {:ok, %User{} = user} <- Users.get(id) do  # Pattern matching
      conn
      |> put_status(:ok)
      |> render(:get, user: user)
    end
  end
  def update(conn, params) do
    with {:ok, %User{} = user} <- Users.update(params) do  # Pattern matching
      conn
      |> put_status(:ok)
      |> render(:update, user: user)
    end
  end
  def delete(conn, %{"id" => id}) do
  with {:ok, %User{} = user} <- Users.delete(id) do  # Pattern matching
    conn
    |> put_status(:ok)
    |> render(:delete, user: user)
  end
end
end
