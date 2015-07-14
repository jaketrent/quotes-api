defmodule QuotesApi.Endpoint do
  use Phoenix.Endpoint, otp_app: :quotes_api

  plug Plug.RequestId
  plug Plug.Logger

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_quotes_api_key",
    signing_salt: "0JWiB8mQ"

  plug :router, QuotesApi.Router
end
