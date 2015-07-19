defmodule QuotesApi.V1.QuoteControllerTest do
  use QuotesApi.ConnCase

  alias QuotesApi.Quote
  @valid_attrs %{author: "some content", body: "some content", title: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_quote_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    quote = Repo.insert! %Quote{}
    conn = get conn, v1_quote_path(conn, :show, quote)
    assert json_response(conn, 200)["data"] == %{
      "id" => quote.id
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_quote_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_quote_path(conn, :create), data: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Quote, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_quote_path(conn, :create), data: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    quote = Repo.insert! %Quote{}
    conn = put conn, v1_quote_path(conn, :update, quote), data: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Quote, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    quote = Repo.insert! %Quote{}
    conn = put conn, v1_quote_path(conn, :update, quote), data: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    quote = Repo.insert! %Quote{}
    conn = delete conn, v1_quote_path(conn, :delete, quote)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Quote, quote.id)
  end
end
