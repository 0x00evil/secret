defmodule BabyWeb.Router do
  use BabyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BabyWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/chat", PageController, :chat
    post "/baby", BabyController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", BabyWeb do
  #   pipe_through :api
  # end
end
