defmodule BananaBank.Users do  # Fachada para as funções de User
  alias BananaBank.Users.Create
  alias BananaBank.Users.Get

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
end
