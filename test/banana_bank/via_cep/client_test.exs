defmodule BananaBank.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  alias BananaBank.ViaCep.Client

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "call/1" do
    test "Sucessfully returns an adress", %{bypass: bypass} do
      cep = "71015082"

      body = ~s({
        "cep": "71015-082",
        "logradouro": "Quadra QI 16 Bloco H",
        "complemento": "",
        "unidade": "",
        "bairro": "Guará I",
        "localidade": "Brasília",
        "uf": "DF",
        "estado": "Distrito Federal",
        "regiao": "Centro-Oeste",
        "ibge": "5300108",
        "gia": "",
        "ddd": "61",
        "siafi": "9701"
      })

      expected_resp = {:ok, %{"bairro" => "Guará I", "cep" => "71015-082", "complemento" => "", "ddd" => "61", "estado" => "Distrito Federal", "gia" => "", "ibge" => "5300108", "localidade" => "Brasília", "logradouro" => "Quadra QI 16 Bloco H", "regiao" => "Centro-Oeste", "siafi" => "9701", "uf" => "DF", "unidade" => ""}}

      Bypass.expect(bypass,"GET","/71015082/json", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response =
      bypass.port
      |> endpoint_url()
      |> Client.call(cep)

      assert response == expected_resp

    end
  end
    defp endpoint_url(port), do: "http://localhost:#{port}"
end
