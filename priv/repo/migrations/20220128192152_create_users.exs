defmodule RrCodeChallenge.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :customer_id, references(:customers, on_delete: :nothing)
      add :name, :string
      add :email, :string

      timestamps()
    end

    create index(:users, [:customer_id])
    create unique_index(:users, [:email])
  end
end
