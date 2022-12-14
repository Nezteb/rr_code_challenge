defmodule RrCodeChallenge.PortfolioManagement do
  alias RrCodeChallenge.Repo
  import Ecto.Query
  alias Schemas

  def grant_user_access_to_customer_folder(_user_id, _folder_id) do
    {:ok, :success}
  end

  def list_vendors_available_to_user(user_id) do
    customer_folder_ids_available_to_user =
      Repo.all(
        from uaf in Schemas.UserAvailableFolder,
          join: cf in Schemas.CustomerFolder,
          on: uaf.customer_folder_id == cf.id,
          where: uaf.user_id == ^user_id,
          select: cf.id
      )

      vendors_available_to_user =
        Repo.all(
          from cva in Schemas.CustomerVendorAllocation,
            join: cv in Schemas.CustomerVendor,
            on: cva.customer_vendor_id == cv.id,
            join: v in Schemas.Vendor,
            on: cv.vendor_id == v.id,
            where: cva.customer_folder_id in ^customer_folder_ids_available_to_user,
            select: v
        )

    {:ok, vendors_available_to_user}
    # {:ok, []}
  end
end
