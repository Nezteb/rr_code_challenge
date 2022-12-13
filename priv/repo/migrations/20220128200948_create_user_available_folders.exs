defmodule RrCodeChallenge.Repo.Migrations.CreateUserAvailableFolders do
  use Ecto.Migration

  def change do
    create table(:user_available_folders) do
      add :customer_folder_id, references(:customer_folders, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:user_available_folders, [:customer_folder_id])
    create index(:user_available_folders, [:user_id])

    create unique_index(:user_available_folders, [
             :customer_folder_id,
             :user_id
           ])
  end
end
