defmodule BananaBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset

  @required_params [:name, :password, :email, :cep]

  @derive {Jason.Encoder, only: [:name, :id, :email, :cep]}
  schema "users" do #mapeamento dos dados
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :email, :string
    field :cep, :string

    timestamps()
  end

  def changeset(user \\%__MODULE__{}, params) do # Used to insert and update
    user
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:name, min: 3)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:cep, is: 8)
    |> add_password_hash()
  end

  defp add_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    password_hash = Argon2.hash_pwd_salt(password)
    change(changeset, %{password_hash: password_hash})
  end

  defp add_password_hash(changeset), do: changeset #Caso da senha não ser válida
end
