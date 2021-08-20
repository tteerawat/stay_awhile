defmodule StayAwhileWeb.API.WebhookController do
  use StayAwhileWeb, :controller

  def handle(conn, %{"lobby_id" => lobby_id}) do
    topic = "webhook:#{lobby_id}"
    :ok = Phoenix.PubSub.broadcast(StayAwhile.PubSub, topic, {:incoming_conn, conn})

    send_resp(conn, 200, "OK")
  end
end
