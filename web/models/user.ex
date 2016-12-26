defmodule Booky.User do
  use Booky.Web, :model

  schema "users" do
    field :name, :string
    field :username, :string
    field :current_member, :boolean
    field :librarian, :boolean

    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:name, :username])
    |> validate_required([:name, :username])
  end
end
