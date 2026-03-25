import Config

username = System.get_env("POSTGRES_USR") || raise "environment variable POSTGRES_USR is missing."
password = System.get_env("POSTGRES_PWD") || raise "environment variable POSTGRES_PWD is missing."
database = System.get_env("POSTGRES_DB") || raise "environment variable POSTGRES_DB is missing."
hostname = System.get_env("POSTGRES_HOST") || raise "environment variable POSTGRES_HOST is missing."
port = System.get_env("POSTGRES_PORT") || raise "environment variable POSTGRES_PORT is missing."


# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :partaches, Partaches.Repo,
  username: username,
  password: password,
  hostname: hostname,
  database: "#{database}_test#{System.get_env("MIX_TEST_PARTITION")}",
  port: String.to_integer(port),
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :partaches, PartachesWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "oD64Te1vrDigoQ6s+RlOAI3hyAGuO8w8YVwK1WJi+wHdcbGPDHrphnpycIBW5l8y",
  server: false

# In test we don't send emails
config :partaches, Partaches.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true

# Sort query params output of verified routes for robust url comparisons
config :phoenix,
  sort_verified_routes_query_params: true
