defmodule PgNotifier.Repo do
  use Ecto.Repo,
    otp_app: :pg_notifier,
    adapter: Ecto.Adapters.Postgres
end
