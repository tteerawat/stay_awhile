defmodule StayAwhileWeb.API.WebhookController do
  use StayAwhileWeb, :controller

  def handle(conn, _params) do
    send_resp(conn, 200, "OK")
  end
end
