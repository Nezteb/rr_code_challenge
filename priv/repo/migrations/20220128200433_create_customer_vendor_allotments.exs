defmodule RrCodeChallenge.Repo.Migrations.CreateCustomerVendorAllotments do
  use Ecto.Migration

  def change do
    create table(:customer_vendor_allotments) do
      add :name, :string
      add :customer_vendor_id, references(:customer_vendors, on_delete: :nothing)
      add :customer_folder_id, references(:customer_folders, on_delete: :nothing)

      timestamps()
    end

    create index(:customer_vendor_allotments, [:customer_vendor_id])
    create index(:customer_vendor_allotments, [:customer_folder_id])
    create unique_index(:customer_vendor_allotments, [:customer_vendor_id, :customer_folder_id])
  end
end
