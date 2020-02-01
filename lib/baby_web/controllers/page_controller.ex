defmodule BabyWeb.PageController do
  use BabyWeb, :controller

  plug :authenticate when action in [:index, :chat]

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def chat(conn, _params) do
    render(conn, "chat.html")
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      put_user_token(conn, conn.assigns.current_user.id)
    else
      conn
      |> put_flash(:error, "You must be logged in to access the page")
      |> redirect(to: Routes.session_path(conn, :new))
      |> halt()
    end
  end

  defp put_user_token(conn, user_id) do
    token = Phoenix.Token.sign(conn, "user socket", user_id)
    assign(conn, :user_token, token)
  end
end
