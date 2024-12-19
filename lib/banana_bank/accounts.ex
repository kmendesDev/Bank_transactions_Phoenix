defmodule BananaBank.Accounts do  # Fachada para as funções de Accounts
  alias BananaBank.Accounts.Create

  defdelegate create(params), to: Create, as: :call

end
