defmodule Booky.User do
  use Booky.Web, :model

  schema "users" do
    field :name, :string
    field :username, :string
    field :current_member, :boolean
    field :librarian, :boolean

    timestamps
  end
end
