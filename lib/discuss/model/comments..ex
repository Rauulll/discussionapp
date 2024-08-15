defmodule Discuss.Model.Comments do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:comments, :user]}

  schema "comments" do
    field :comments, :string

    belongs_to (:topic), Discuss.Model.Topic
    belongs_to (:user), Discuss.Model.User
  end

  def changeset(comment, attr \\ %{}) do
    comment
    |> cast(attr, [:comments, :user_id, :topic_id])
    |> validate_required([:comments])
  end
end
