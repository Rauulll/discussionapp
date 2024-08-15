defmodule Discuss.Model.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :description, :string
    field :title, :string

    belongs_to :user, Discuss.Model.User
    has_many :comments, Discuss.Model.Comments

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(topic, attrs \\ %{}) do
    topic
    |> cast(attrs, [:title, :description, :user_id])
    |> validate_required([:title, :description, :user_id])
  end
end
