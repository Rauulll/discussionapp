defmodule DiscussWeb.Plugs.RequireAuth do
  use DiscussWeb, :controller

  import Plug.Conn

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You must be Logged in")
      |> redirect(to: ~p"/topics")
      |> halt()
    end
  end
end
