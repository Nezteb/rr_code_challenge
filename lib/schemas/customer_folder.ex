defmodule Schemas.CustomerFolder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customer_folders" do
    field :name, :string
    belongs_to :customer, Schemas.Customer

    timestamps()
  end

  @doc false
  def changeset(customer_folder, attrs) do
    customer_folder
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
