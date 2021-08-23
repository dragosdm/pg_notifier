import Config

config :pg_notifier, ecto_repos: [PgNotifier.Repo]

config :pg_notifier, PgNotifier.Repo,
  username: "postgres",
  password: "postgres",
  database: "pg_notifier_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
