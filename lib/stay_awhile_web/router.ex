defmodule StayAwhileWeb.Router do
  use StayAwhileWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {StayAwhileWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StayAwhileWeb do
    pipe_through :browser

    live "/incoming-webhook-requests", IncomingWebhookRequestLive
  end

  scope "/api", StayAwhileWeb.API do
    pipe_through :api

    post "/webhook", WebhookController, :handle
  end
end
