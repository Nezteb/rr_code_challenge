defmodule Schemas.CustomerVendorAllocation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customer_vendor_allotments" do
    field :name, :string
    belongs_to :customer_vendor, Schemas.CustomerVendor
    belongs_to :customer_folder, Schemas.CustomerFolder

    timestamps()
  end

  @doc false
  def changeset(customer_vendor_allocation, attrs) do
    customer_vendor_allocation
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
