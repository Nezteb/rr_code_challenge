defmodule RrCodeChallenge.PortfolioManagement do
  def grant_user_access_to_customer_folder(_user_id, _folder_id) do
    {:ok, :success}
  end

  def list_vendors_available_to_user(_user_id) do
    {:ok, []}
  end
end
