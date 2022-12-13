defmodule RrCodeChallenge.Repo do
  use Ecto.Repo,
    otp_app: :rr_code_challenge,
    adapter: Ecto.Adapters.Postgres
end
