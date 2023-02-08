defmodule HelloVersionWeb.QuotationJSON do
  alias HelloVersion.Content.Quotation

  @doc """
  Renders a list of quotations.
  """
  def index(%{quotations: quotations}) do
    %{data: for(quotation <- quotations, do: data(quotation))}
  end

  @doc """
  Renders a single quotation.
  """
  def show(%{quotation: quotation}) do
    %{data: data(quotation)}
  end

  defp data(%Quotation{} = quotation) do
    %{
      id: quotation.id,
      quote: quotation.quote,
      author: quotation.author,
      book: quotation.book
    }
  end
end
