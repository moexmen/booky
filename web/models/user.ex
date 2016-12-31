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

  def set_member_flag(model, params \\ :empty) do
    model
    |> cast(params, [:current_member])
    |> put_change(:current_member, params.current_member)
  end
end
