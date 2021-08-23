defmodule PgNotifier.Repo.Migrations.CreateNotifyFunction do
  use Ecto.Migration

  def change do
    """
    CREATE OR REPLACE FUNCTION notify_row_changes()
    RETURNS trigger AS $$
    BEGIN
      PERFORM pg_notify(
        'row_changed',
        json_build_object(
          'table', TG_TABLE_NAME,
          'operation', TG_OP,
          'record', row_to_json(NEW)
        )::text
      );
    RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;
    """
    |> execute()
  end
end
