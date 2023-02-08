defmodule HelloVersion.Repo.Migrations.CreateQuotations do
  use Ecto.Migration

  def change do
    create table(:quotations) do
      add :quote, :text
      add :author, :string
      add :book, :string

      timestamps()
    end
  end
end
