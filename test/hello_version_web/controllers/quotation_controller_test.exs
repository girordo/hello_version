defmodule HelloVersionWeb.QuotationControllerTest do
  use HelloVersionWeb.ConnCase

  import HelloVersion.ContentFixtures

  alias HelloVersion.Content.Quotation

  @create_attrs %{
    author: "some author",
    book: "some book",
    quote: "some quote"
  }
  @update_attrs %{
    author: "some updated author",
    book: "some updated book",
    quote: "some updated quote"
  }
  @invalid_attrs %{author: nil, book: nil, quote: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all quotations", %{conn: conn} do
      conn = get(conn, ~p"/api/quotations")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create quotation" do
    test "renders quotation when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/quotations", quotation: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/quotations/#{id}")

      assert %{
               "id" => ^id,
               "author" => "some author",
               "book" => "some book",
               "quote" => "some quote"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/quotations", quotation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update quotation" do
    setup [:create_quotation]

    test "renders quotation when data is valid", %{conn: conn, quotation: %Quotation{id: id} = quotation} do
      conn = put(conn, ~p"/api/quotations/#{quotation}", quotation: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/quotations/#{id}")

      assert %{
               "id" => ^id,
               "author" => "some updated author",
               "book" => "some updated book",
               "quote" => "some updated quote"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, quotation: quotation} do
      conn = put(conn, ~p"/api/quotations/#{quotation}", quotation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete quotation" do
    setup [:create_quotation]

    test "deletes chosen quotation", %{conn: conn, quotation: quotation} do
      conn = delete(conn, ~p"/api/quotations/#{quotation}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/quotations/#{quotation}")
      end
    end
  end

  defp create_quotation(_) do
    quotation = quotation_fixture()
    %{quotation: quotation}
  end
end
