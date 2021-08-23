defmodule PgNotifier.Listener do
  use GenServer

  require Logger

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(opts) do
    with {:ok, _pid, _ref} <- listen("row_changed") do
      {:ok, opts}
    else
      error -> {:stop, error}
    end
  end

  def handle_info({:notification, _pid, _ref, "row_changed", payload}, _state) do
    with {:ok, data} <- Jason.decode(payload, keys: :atoms),
         %{operation: op, table: table, record: record} <- data do
      # TODO: do something with the data
      Logger.info("#{op} - #{table} - #{inspect(record)}")

      {:noreply, :event_handled}
    else
      error -> {:stop, error, []}
    end
  end

  def listen(event_name) do
    opts =
      Keyword.take(Application.get_env(:pg_notifier, PgNotifier.Repo), [
        :username,
        :database,
        :hostname,
        :port,
        :password
      ])

    with {:ok, pid} <- Postgrex.Notifications.start_link(opts),
         {:ok, ref} <- Postgrex.Notifications.listen(pid, event_name) do
      {:ok, pid, ref}
    end
  end
end
