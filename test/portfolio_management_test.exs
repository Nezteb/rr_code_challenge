defmodule Data.PortfolioManagementTest do
  use RrCodeChallengeWeb.ConnCase, async: true
  alias RrCodeChallenge.Factory

  describe "grant_user_access_to_customer_folder/2" do
    setup [
      :setup_user,
      :setup_customer_vendors,
      :setup_other_customer_vendors,
      :setup_customer_folders,
      :setup_other_customer_folders,
      :setup_customer_vendor_allocations,
      :setup_user_available_folders
    ]

    test "assert user can't get access to another customer's folder", %{
      user: user,
      other_customer_folders: [folder | _]
    } do
      assert {:error, :unauthorized} =
               RrCodeChallenge.PortfolioManagement.grant_user_access_to_customer_folder(
                 user.id,
                 folder.id
               )
    end

    test "assert no duplicates", %{user: user, customer_folders: [existing_user_folder | _]} do
      assert {:ok, :noop} =
               RrCodeChallenge.PortfolioManagement.grant_user_access_to_customer_folder(
                 user.id,
                 existing_user_folder.id
               )
    end

    test "assert user gets access to new folder", %{
      user: user,
      customer_folders: customer_folders
    } do
      folder = Enum.at(customer_folders, 4)

      assert {:ok, :added} =
               RrCodeChallenge.PortfolioManagement.grant_user_access_to_customer_folder(
                 user.id,
                 folder.id
               )
    end
  end

  describe "list_vendors_available_to_user/1" do
    setup [
      :setup_user,
      :setup_customer_vendors,
      :setup_other_customer_vendors,
      :setup_customer_folders,
      :setup_other_customer_folders,
      :setup_customer_vendor_allocations,
      :setup_user_available_folders
    ]

    test "assert user only has access to vendors he has access to via folder structure", %{
      user: user
    } do
      {:ok, results} = RrCodeChallenge.PortfolioManagement.list_vendors_available_to_user(user.id)

      assert length(results) == 4
    end

    test "assert user has access to more vendors after given another folder access", %{
      user: user,
      customer_folders: customer_folders
    } do
      new_folder = Enum.at(customer_folders, 3)

      RrCodeChallenge.PortfolioManagement.grant_user_access_to_customer_folder(
        user.id,
        new_folder.id
      )

      {:ok, results} = RrCodeChallenge.PortfolioManagement.list_vendors_available_to_user(user.id)

      assert length(results) == 6
    end
  end

  # Setup Helpers
  defp setup_user(_) do
    customer = Factory.insert!(:customer)
    user = Factory.insert!(:user)

    {:ok, [user: user, customer: customer]}
  end

  defp setup_customer_vendors(%{customer: customer}) do
    customer_vendors =
      1..10
      |> Enum.map(fn _ ->
        Factory.insert!(:customer_vendor, customer: customer)
      end)

    {:ok, [customer_vendors: customer_vendors]}
  end

  defp setup_other_customer_vendors(_) do
    other_customer_vendors =
      1..10
      |> Enum.map(fn _ ->
        Factory.insert!(:customer_vendor)
      end)

    {:ok, [other_customer_vendors: other_customer_vendors]}
  end

  defp setup_customer_folders(%{customer: customer}) do
    customer_folders =
      1..5
      |> Enum.map(fn _ ->
        Factory.insert!(:customer_folder, customer: customer)
      end)

    {:ok, [customer_folders: customer_folders]}
  end

  defp setup_other_customer_folders(_) do
    other_customer_folders =
      1..5
      |> Enum.map(fn _ ->
        Factory.insert!(:customer_folder)
      end)

    {:ok, [other_customer_folders: other_customer_folders]}
  end

  def setup_customer_vendor_allocations(%{
        customer_vendors: customer_vendors,
        customer_folders: customer_folders
      }) do
    allocations =
      customer_vendors
      |> Enum.chunk_every(2)
      |> Enum.with_index()
      |> Enum.flat_map(fn {vendors_group, idx} ->
        Enum.map(vendors_group, fn customer_vendor ->
          Factory.insert!(:customer_vendor_allocation,
            customer_vendor: customer_vendor,
            customer_folder: Enum.at(customer_folders, idx)
          )
        end)
      end)

    {:ok, [customer_vendor_allocations: allocations]}
  end

  def setup_user_available_folders(%{user: user, customer_folders: customer_folders}) do
    user_available_folders =
      customer_folders
      |> Enum.take(2)
      |> Enum.map(fn folder ->
        Factory.insert!(:user_available_folder, user: user, customer_folder: folder)
      end)

    {:ok, [user_available_folders: user_available_folders]}
  end
end
