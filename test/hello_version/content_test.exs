defmodule HelloVersion.ContentTest do
  use HelloVersion.DataCase

  alias HelloVersion.Content

  describe "quotations" do
    alias HelloVersion.Content.Quotation

    import HelloVersion.ContentFixtures

    @invalid_attrs %{author: nil, book: nil, quote: nil}

    test "list_quotations/0 returns all quotations" do
      quotation = quotation_fixture()
      assert Content.list_quotations() == [quotation]
    end

    test "get_quotation!/1 returns the quotation with given id" do
      quotation = quotation_fixture()
      assert Content.get_quotation!(quotation.id) == quotation
    end

    test "create_quotation/1 with valid data creates a quotation" do
      valid_attrs = %{author: "some author", book: "some book", quote: "some quote"}

      assert {:ok, %Quotation{} = quotation} = Content.create_quotation(valid_attrs)
      assert quotation.author == "some author"
      assert quotation.book == "some book"
      assert quotation.quote == "some quote"
    end

    test "create_quotation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_quotation(@invalid_attrs)
    end

    test "update_quotation/2 with valid data updates the quotation" do
      quotation = quotation_fixture()
      update_attrs = %{author: "some updated author", book: "some updated book", quote: "some updated quote"}

      assert {:ok, %Quotation{} = quotation} = Content.update_quotation(quotation, update_attrs)
      assert quotation.author == "some updated author"
      assert quotation.book == "some updated book"
      assert quotation.quote == "some updated quote"
    end

    test "update_quotation/2 with invalid data returns error changeset" do
      quotation = quotation_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_quotation(quotation, @invalid_attrs)
      assert quotation == Content.get_quotation!(quotation.id)
    end

    test "delete_quotation/1 deletes the quotation" do
      quotation = quotation_fixture()
      assert {:ok, %Quotation{}} = Content.delete_quotation(quotation)
      assert_raise Ecto.NoResultsError, fn -> Content.get_quotation!(quotation.id) end
    end

    test "change_quotation/1 returns a quotation changeset" do
      quotation = quotation_fixture()
      assert %Ecto.Changeset{} = Content.change_quotation(quotation)
    end
  end
end
