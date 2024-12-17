defmodule BananaBankWeb.UserControllerTest do # Conn case - usa sandbox, dps faz rollback e é usado quando precisa de conexão
  use BananaBankWeb.ConnCase

  import Mox
  alias BananaBank.Users
  #alias Users.User

  setup do
    params = %{
      "name" => "Jhonny",
      "cep" => "59071050",
      "email" => "jhow@bb.com",
      "password" => "098765"
    }
    body = %{
      "bairro" => "Cidade da Esperança",
      "cep" => "59071-050",
      "complemento" => "",
      "ddd" => "84",
      "estado" => "Rio Grande do Norte",
      "gia" => "",
      "ibge" => "2408102",
      "localidade" => "Natal",
      "logradouro" => "Rua Fortaleza",
      "regiao" => "Nordeste",
      "siafi" => "1761",
      "uf" => "RN",
      "unidade" => ""
    }
    {:ok, %{user_params: params, body: body}}
  end

  describe "create/2" do
    test "sucessfully creates an user", %{conn: conn, body: body, user_params: params} do
      expect(BananaBank.ViaCep.ClientMock, :call, fn "59071050" ->
        {:ok, body}
      end)

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created) # status 201 / :ok é status 200

      assert %{
                "data" => %{"cep" => "59071050", "email" => "jhow@bb.com", "id" => _id, "name" => "Jhonny"},
                "message" => "User created !"
              } = response  # pattern matching
    end
    test "With invalid params, returns an error", %{conn: conn} do

      params = %{
        "name" => "Jhonny",
        "cep" => "12",
        "email" => "jhow@bb.com",
        "password" => "098765"
      }
      expect(BananaBank.ViaCep.ClientMock, :call, fn "12" ->
        {:ok, ""}
      end)


      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

      assert %{"errors" => %{"cep" => ["should be 8 character(s)"]}} = response  # pattern matching
    end
  end
  describe "delete/2" do
    test "sucessfully deletes an user", %{conn: conn, body: body, user_params: params} do

      expect(BananaBank.ViaCep.ClientMock, :call, fn "59071050" ->
        {:ok, body}
      end)

      {:ok, user} = Users.create(params)


      response =
        conn
        |> delete(~p"/api/users/#{user.id}")
        |> json_response(:ok) # status 201 / :ok é status 200

      assert %{
                "data" => %{"cep" => "59071050", "email" => "jhow@bb.com", "id" => _id, "name" => "Jhonny"},
                "message" => "User deleted !"
              } = response  # pattern matching
    end
  end
end
