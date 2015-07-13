defmodule QuotesApi.Router do
  use QuotesApi.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", QuotesApi do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      resources "/quotes", QuoteController
    end
  end
end
