defmodule RrCodeChallenge.PortfolioManagement do
  alias RrCodeChallenge.Repo
  import Ecto.Query

  alias Schemas.{
    UserAvailableFolder,
    CustomerFolder,
    CustomerVendorAllocation,
    Vendor,
    CustomerVendor,
    Customer,
    User
  }

  def grant_user_access_to_customer_folder(user_id, folder_id) do
    user_ids_allowed_to_access_folder = Repo.all(
      from c in Customer,
        left_join: u in User,
        on: u.customer_id == c.id,
        left_join: cf in CustomerFolder,
        on: cf.customer_id == c.id,
        where: cf.id == ^folder_id,
        select: u.id
    )

    if user_id in user_ids_allowed_to_access_folder do
      create_user_folder_relation(user_id, folder_id)
    else
      {:error, :unauthorized}
    end
  end

  defp create_user_folder_relation(user_id, folder_id) do
    UserAvailableFolder.create_changeset(%{
      user_id: user_id,
      customer_folder_id: folder_id
    })
    |> Repo.insert()
    |> case do
      {:ok, _} -> {:ok, :success}
      # Instead of doing a query to check if the relation exists, we'll try the insert and parse out an index violation
      {:error, %{errors: [customer_folder_id: {"has already been taken", _}]}} -> {:ok, :noop}
      {:error, error} -> {:error, error}
    end
  end

  def list_vendors_available_to_user(user_id) do
    customer_folder_ids_available_to_user =
      Repo.all(
        from uaf in UserAvailableFolder,
          join: cf in CustomerFolder,
          on: uaf.customer_folder_id == cf.id,
          where: uaf.user_id == ^user_id,
          select: cf.id
      )

    vendors_available_to_user =
      Repo.all(
        from cva in CustomerVendorAllocation,
          join: cv in CustomerVendor,
          on: cva.customer_vendor_id == cv.id,
          join: v in Vendor,
          on: cv.vendor_id == v.id,
          where: cva.customer_folder_id in ^customer_folder_ids_available_to_user,
          select: v
      )

    {:ok, vendors_available_to_user}
  end
end
