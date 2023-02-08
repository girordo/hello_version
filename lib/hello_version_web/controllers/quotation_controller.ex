defmodule HelloVersionWeb.QuotationController do
  use HelloVersionWeb, :controller

  alias HelloVersion.Content
  alias HelloVersion.Content.Quotation

  action_fallback HelloVersionWeb.FallbackController

  def index(conn, _params) do
    quotations = Content.list_quotations()
    render(conn, :index, quotations: quotations)
  end

  def create(conn, %{"quotation" => quotation_params}) do
    with {:ok, %Quotation{} = quotation} <- Content.create_quotation(quotation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/quotations/#{quotation}")
      |> render(:show, quotation: quotation)
    end
  end

  def show(conn, %{"id" => id}) do
    quotation = Content.get_quotation!(id)
    render(conn, :show, quotation: quotation)
  end

  def update(conn, %{"id" => id, "quotation" => quotation_params}) do
    quotation = Content.get_quotation!(id)

    with {:ok, %Quotation{} = quotation} <- Content.update_quotation(quotation, quotation_params) do
      render(conn, :show, quotation: quotation)
    end
  end
end
