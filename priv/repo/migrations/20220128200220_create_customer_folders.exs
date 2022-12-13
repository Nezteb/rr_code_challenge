defmodule RrCodeChallenge.Repo.Migrations.CreateCustomerFolders do
  use Ecto.Migration

  def change do
    create table(:customer_folders) do
      add :name, :string
      add :customer_id, references(:customers, on_delete: :nothing)

      timestamps()
    end

    create index(:customer_folders, [:customer_id])
  end
end
