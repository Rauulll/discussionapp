defmodule Discuss.Repo.Migrations.AddDescriptionToTopics do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      add :description, :string
    end
  end
end
