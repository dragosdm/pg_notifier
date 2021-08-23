defmodule PgNotifier.Repo.Migrations.CreateNotificationsTable do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add(:message, :string, null: false)
      add(:type, :string, null: false)

      timestamps(updated_at: false)
    end
  end
end
