import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :rr_code_challenge, RrCodeChallenge.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "rr_code_challenge_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rr_code_challenge, RrCodeChallengeWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "AwZAdKZXms9a9Qz4DWor5Q6LTN7VArlwTlNHN/4BchaXTdp3B7y4Rz9RlnKmEYcd",
  server: false

# In test we don't send emails.
config :rr_code_challenge, RrCodeChallenge.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
