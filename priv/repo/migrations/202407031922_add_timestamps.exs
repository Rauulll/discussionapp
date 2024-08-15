defmodule Discuss.Repo.Migrations.AddDescriptionToTopics do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      add :inserted_at, :naive_datetime, default: fragment("CURRENT_TIMESTAMP"), null: true
      add :updated_at, :naive_datetime, default: fragment("CURRENT_TIMESTAMP"), null: true
    end

    # Use execute to update existing rows immediately
    execute "UPDATE topics SET inserted_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP WHERE inserted_at IS NULL OR updated_at IS NULL"

    # Separate alter table block for modifying columns to not allow nulls
    alter table(:topics) do
      modify :inserted_at, :naive_datetime, null: false
      modify :updated_at, :naive_datetime, null: false
    end
  end
end
