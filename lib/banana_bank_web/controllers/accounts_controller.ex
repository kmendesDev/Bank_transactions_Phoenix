defmodule BananaBankWeb.AccountsController do
  use BananaBankWeb, :controller

  alias BananaBank.Accounts
  alias Accounts.Account

  # Toda vez que der erro, vai pro FallbackController
  action_fallback BananaBankWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Account{} = account} <- Accounts.create(params) do  # Pattern matching
      conn
      |> put_status(:created)
      |> render(:create, account: account)
    end
  end
  def transaction(conn, params) do
    with {:ok, transaction} <- Accounts.transaction(params) do  # Pattern matching
      conn
      |> put_status(:ok)
      |> render(:transaction, transaction: transaction)
    end
  end
end
