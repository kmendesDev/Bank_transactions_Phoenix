defmodule BananaBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset

  @required_params_create [:name, :password, :email, :cep]
  @required_params_update [:name, :email, :cep]

  @derive {Jason.Encoder, only: [:name, :id, :email, :cep]}
  schema "users" do #mapeamento dos dados
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :email, :string
    field :cep, :string

    timestamps()
  end
  def changeset(params) do # Used to create
    %__MODULE__{}
    |> cast(params, @required_params_create)
    |> do_validations(@required_params_create)
    |> add_password_hash()
  end
  def changeset(user, params) do # Used to update
    user
    |> cast(params, @required_params_create)
    |> do_validations(@required_params_update)
    |> add_password_hash()
  end
  defp do_validations(changeset, fields) do
    changeset
    |> validate_required(fields)
    |> validate_length(:name, min: 3)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:cep, is: 8)
  end

  defp add_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    password_hash = Argon2.hash_pwd_salt(password)
    change(changeset, %{password_hash: password_hash})
  end

  defp add_password_hash(changeset), do: changeset #Caso da senha não ser válida
end
