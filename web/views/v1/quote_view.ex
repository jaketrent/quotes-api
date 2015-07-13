defmodule QuotesApi.V1.QuoteView do
  use QuotesApi.Web, :view

  def render("index.json", %{quotes: quotes}) do
    %{data: render_many(quotes, QuotesApi.V1.QuoteView, "quote.json")}
  end

  def render("show.json", %{quote: quote}) do
    %{data: render_one(quote, QuotesApi.V1.QuoteView, "quote.json")}
  end

  def render("quote.json", %{quote: quote}) do
    %{id: quote.id}
  end
end
