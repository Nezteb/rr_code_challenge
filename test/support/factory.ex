defmodule RrCodeChallenge.Factory do
  alias RrCodeChallenge.Repo

  # Factories

  def build(:customer_folder) do
    %Schemas.CustomerFolder{customer: build(:customer), name: Faker.Team.name()}
  end

  def build(:customer) do
    %Schemas.Customer{name: Faker.Company.name()}
  end

  def build(:customer_vendor) do
    %Schemas.CustomerVendor{customer: build(:customer), vendor: build(:vendor)}
  end

  def build(:customer_vendor_allocation) do
    %Schemas.CustomerVendorAllocation{
      customer_vendor: build(:customer_vendor),
      customer_folder: build(:customer_folder)
    }
  end

  def build(:user_available_folder) do
    %Schemas.UserAvailableFolder{
      user: build(:user),
      customer_folder: build(:customer_folder)
    }
  end

  def build(:user) do
    %Schemas.User{
      email: Faker.Internet.email(),
      name: Faker.Internet.user_name()
    }
  end

  def build(:vendor) do
    %Schemas.Vendor{
      name: Faker.Company.name()
    }
  end

  # Convenience API

  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end
end
