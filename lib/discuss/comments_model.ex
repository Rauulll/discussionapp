defmodule Discuss.CommentsModel do
  import Ecto.Query, warn: false

  alias Discuss.{Model.Comments, Repo}

  # Create comment
  def create_comment(comment \\ %Comments{}, attrs \\ %{}) do
    comment
    |> Comments.changeset(attrs)
    |> Repo.insert()
  end

  # Get comment
  def get_comment(id), do: Repo.get!(Comments, id)
end
