defmodule BananaBankWeb.AccountsJSON do

  alias BananaBank.Accounts.Account

  def create(%{account: account}) do
    %{
      message: "Account created !",
      data: data(account)
    }
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      balance: account.balance,
      user_id: account.user_id
    }
  end
end
