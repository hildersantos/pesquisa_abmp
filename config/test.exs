use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :pesquisa_abmp, PesquisaABMP.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :pesquisa_abmp, PesquisaABMP.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "pesquisa_abmp_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
