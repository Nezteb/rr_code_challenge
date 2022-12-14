defmodule Schemas.UserAvailableFolder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_available_folders" do
    belongs_to :customer_folder, Schemas.CustomerFolder
    belongs_to :user, Schemas.User

    timestamps()
  end

  @doc false
  def changeset(user_available_folder, attrs) do
    user_available_folder
    |> cast(attrs, [:user_id, :customer_folder_id])
    |> cast_assoc(:user)
    |> cast_assoc(:customer_folder)
    |> validate_required([])
  end

  def create_changeset(attrs),
    do: %__MODULE__{} |> changeset(attrs)
end
