defmodule Booky.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :author, :string
      add :status, :string
      add :description, :string
      add :remarks, :string
      add :borrower_id, references(:users, on_delete: :nothing)

      timestamps()
    end

  end
end
