defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel
  alias Discuss.{Model, CommentsModel, Repo}


  def join("comments:" <> topic_id, _message, socket) do
    topic_id = String.to_integer(topic_id)
    topic =
      Model.get_topic!(topic_id)
      |> Repo.preload(comments: [:user])

    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(_name, %{"content" => comment}, socket) do

    topic = socket.assigns.topic
    user_id = socket.assigns.user_id

    result =
      topic
      |> Ecto.build_assoc(:comments, user_id: user_id)
      |> CommentsModel.create_comment(%{comments: comment})

    case result do
      {:ok, comment} ->
        broadcast!(
          socket,
          "comments:#{topic.id}:new",
          %{comment: comment}
        )
        {:reply, :ok, socket}
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, {%{changeset: changeset}}, socket}
    end
  end
end
