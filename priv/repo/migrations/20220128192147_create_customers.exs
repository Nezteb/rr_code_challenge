defmodule RrCodeChallenge.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :name, :string

      timestamps()
    end
  end
end
