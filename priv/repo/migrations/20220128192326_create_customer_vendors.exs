defmodule RrCodeChallenge.Repo.Migrations.CreateCustomerVendors do
  use Ecto.Migration

  def change do
    create table(:customer_vendors) do
      add :customer_id, references(:customers, on_delete: :nothing)
      add :vendor_id, references(:vendors, on_delete: :nothing)

      timestamps()
    end

    create index(:customer_vendors, [:customer_id])
    create index(:customer_vendors, [:vendor_id])
    create unique_index(:customer_vendors, [:customer_id, :vendor_id])
  end
end
