defmodule PgNotifier.Repo.Migrations.CreateNotificationsTrigger do
  use Ecto.Migration

  def change do
    """
    CREATE TRIGGER notifications_changed
    AFTER INSERT OR UPDATE ON notifications
    FOR EACH ROW
    EXECUTE PROCEDURE notify_row_changes()
    """
    |> execute()
  end
end
