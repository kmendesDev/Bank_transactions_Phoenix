Mox.defmock(BananaBank.ViaCep.ClientMock, for: BananaBank.ViaCep.ClientBehaviour) # <- Add this
Application.put_env(:banana_bank, :via_cep_client, BananaBank.ViaCep.ClientMock) # <- Add this

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(BananaBank.Repo, :manual)
