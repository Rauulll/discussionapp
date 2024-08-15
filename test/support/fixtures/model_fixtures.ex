defmodule Discuss.ModelFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Discuss.Model` context.
  """

  @doc """
  Generate a topic.
  """
  def topic_fixture(attrs \\ %{}) do
    {:ok, topic} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title"
      })
      |> Discuss.Model.create_topic()

    topic
  end
end
