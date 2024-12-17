defmodule BananaBankWeb.UserControllerTest do # Conn case - usa sandbox, dps faz rollback e é usado quando precisa de conexão
  use BananaBankWeb.ConnCase

  alias BananaBank.Users

  describe "create/2" do
    test "sucessfully creates an user", %{conn: conn} do

      params = %{
        "name" => "Jhonny",
        "cep" => "09876098",
        "email" => "jhow@bb.com",
        "password" => "098765"
      }
      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created) # status 201 / :ok é status 200

      assert %{
                "data" => %{"cep" => "09876098", "email" => "jhow@bb.com", "id" => _id, "name" => "Jhonny"},
                "message" => "User created !"
              } = response  # pattern matching
    end
    test "With invalid params, returns an error", %{conn: conn} do

      params = %{
        "name" => "Jhonny",
        "cep" => "09876098",
        "email" => "jhow@bb.com",
        "password" => " "
      }
      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

      assert %{"errors" => %{"password" => ["can't be blank"]}} = response  # pattern matching
    end
  end
  describe "delete/2" do
    test "sucessfully deletes an user", %{conn: conn} do

      params = %{   # Pesquisar a lib exmachina
        "name" => "Jhonny",
        "cep" => "09876098",
        "email" => "jhow@bb.com",
        "password" => "098765"
      }

      {:ok, user} = Users.create(params)


      response =
        conn
        |> delete(~p"/api/users/#{user.id}")
        |> json_response(:ok) # status 201 / :ok é status 200

      assert %{
                "data" => %{"cep" => "09876098", "email" => "jhow@bb.com", "id" => _id, "name" => "Jhonny"},
                "message" => "User deleted !"
              } = response  # pattern matching
    end
  end
end
