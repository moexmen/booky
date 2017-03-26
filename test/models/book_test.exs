defmodule Booky.BookTest do
  use Booky.ModelCase

  alias Booky.Book

  @valid_attrs %{author: "some content", description: "some content", remarks: "some content", status: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Book.changeset(%Book{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Book.changeset(%Book{}, @invalid_attrs)
    refute changeset.valid?
  end
end
