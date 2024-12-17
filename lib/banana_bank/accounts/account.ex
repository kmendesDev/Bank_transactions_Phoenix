defmodule BananaBank.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  alias BananaBank.Users.User

  @required_params [:balance, :user_id]

  schema "accounts" do #mapeamento dos dados
    field :balance, :decimal
    belongs_to :user, User

    timestamps()
  end
  def changeset(account \\ %__MODULE__{}, params) do # Used to create
    account
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> check_constraint(:balance, name: :balance_must_be_positive)
  end
end
