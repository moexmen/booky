defmodule Booky.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    execute "CREATE TYPE book_status AS ENUM ('available', 'onloan', 'missing', 'removed')"
    create table(:books) do
      add :title, :string
      add :author, :string
      add :status, :book_status
      add :description, :string
      add :remarks, :string
      add :borrower_id, references(:users, on_delete: :nothing)

      timestamps()
    end

  end
end
