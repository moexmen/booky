defmodule Booky.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :username, :string, null: false
      add :current_member, :boolean, null: false, default: true
      add :librarian, :boolean, null: false, default: false

      timestamps
    end

    create unique_index(:users, [:username])
  end
end
