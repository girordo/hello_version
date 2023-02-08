defmodule HelloVersion.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HelloVersion.Content` context.
  """

  @doc """
  Generate a quotation.
  """
  def quotation_fixture(attrs \\ %{}) do
    {:ok, quotation} =
      attrs
      |> Enum.into(%{
        author: "some author",
        book: "some book",
        quote: "some quote"
      })
      |> HelloVersion.Content.create_quotation()

    quotation
  end
end
