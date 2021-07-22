defmodule StayAwhileWeb.API.WebhookController do
  use StayAwhileWeb, :controller

  def handle(conn, _) do
    Phoenix.PubSub.broadcast(StayAwhile.PubSub, "webhook", {:incoming_conn, conn})

    send_resp(conn, 200, "OK")
  end
end
