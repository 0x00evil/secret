defmodule BabyWeb.Router do
  use BabyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :authenticate_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BabyWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/chat", PageController, :chat
    post "/baby", BabyController, :index

    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete], singleton: true
  end

  # Other scopes may use custom stacks.
  # scope "/api", BabyWeb do
  #   pipe_through :api
  # end

  defp authenticate_user(conn, _) do
    user_id = get_session(conn, :user_id)
    user = user_id && Baby.Accounts.get_user!(user_id)
    assign(conn, :current_user, user)
  end
end
