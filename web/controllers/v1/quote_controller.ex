defmodule QuotesApi.V1.QuoteController do
  use QuotesApi.Web, :controller

  alias QuotesApi.Quote

  plug :scrub_params, "quote" when action in [:create, :update]

  def index(conn, _params) do
    quotes = Repo.all(Quote)
    render(conn, "index.json", quotes: quotes)
  end

  def create(conn, %{"quote" => quote_params}) do
    changeset = Quote.changeset(%Quote{}, quote_params)

    if changeset.valid? do
      quote = Repo.insert!(changeset)
      render(conn, "show.json", quote: quote)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(QuotesApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    quote = Repo.get!(Quote, id)
    render conn, "show.json", quote: quote
  end

  def update(conn, %{"id" => id, "quote" => quote_params}) do
    quote = Repo.get!(Quote, id)
    changeset = Quote.changeset(quote, quote_params)

    if changeset.valid? do
      quote = Repo.update!(changeset)
      render(conn, "show.json", quote: quote)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(QuotesApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    quote = Repo.get!(Quote, id)

    quote = Repo.delete!(quote)
    render(conn, "show.json", quote: quote)
  end
end
