defmodule Discuss.Plugs.SetUser do
  import Plug.Conn

  alias Discuss.UserModel

  def init(_params) do
  end

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    cond do
      user = user_id && UserModel.get_user(user_id) ->
        conn
        |> put_user_token(user)
        |> assign(:user, user)
      true ->
        assign(conn, :user, nil)
    end
  end

  defp put_user_token(conn, user) do
    user_id = Phoenix.Token.sign(conn, "key", user.id)
    assign(conn, :user_token, user_id)
  end
end
