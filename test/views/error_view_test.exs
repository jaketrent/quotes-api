defmodule QuotesApi.ErrorViewTest do
  use QuotesApi.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json" do
    err = %{ reason: %{ message: "Cant find you" }, plug_status: 444 }

    assert render_to_string(QuotesApi.ErrorView, "404.json", err) ==
           "{\"errors\":[{\"status\":\"error\",\"detail\":\"Cant find you\",\"code\":\"internal-server\"}]}"
  end

  test "render 500.json" do
    err = %{ reason: %{ message: "Blew up" }, plug_status: 500 }
    assert render_to_string(QuotesApi.ErrorView, "500.json", err) ==
           "{\"errors\":[{\"status\":\"error\",\"detail\":\"Blew up\",\"code\":\"internal-server\"}]}"
  end

  test "render any other" do
    err = %{ reason: %{ message: "Weird err" }, plug_status: 505 }
    assert render_to_string(QuotesApi.ErrorView, "505.json", err) ==
           "{\"errors\":[{\"status\":\"error\",\"detail\":\"Weird err\",\"code\":\"internal-server\"}]}"
  end
end
