defmodule HelloVersion.Content.Quotation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotations" do
    field :author, :string
    field :book, :string
    field :quote, :string

    timestamps()
  end

  @doc false
  def changeset(quotation, attrs) do
    quotation
    |> cast(attrs, [:quote, :author, :book])
    |> validate_required([:quote, :author, :book])
  end
end
