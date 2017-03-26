defmodule Booky.Book do
  use Booky.Web, :model

  schema "books" do
    field :title, :string
    field :author, :string
    field :status, :string
    field :description, :string
    field :remarks, :string

    belongs_to :borrower, Booky.User, foreign_key: :borrower_id 
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :author, :status, :description, :remarks])
    |> validate_required([:title, :author, :status, :description, :remarks])
  end
end
