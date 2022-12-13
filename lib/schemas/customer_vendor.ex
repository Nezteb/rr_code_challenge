defmodule Schemas.CustomerVendor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customer_vendors" do
    belongs_to :customer, Schemas.Customer
    belongs_to :vendor, Schemas.Vendor

    timestamps()
  end

  @doc false
  def changeset(customer_vendor, attrs) do
    customer_vendor
    |> cast(attrs, [])
    |> validate_required([])
  end
end
