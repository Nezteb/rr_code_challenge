defmodule Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    belongs_to :customer, Schemas.Customer
    field :email, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
