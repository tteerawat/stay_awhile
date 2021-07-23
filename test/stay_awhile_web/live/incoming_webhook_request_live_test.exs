defmodule StayAwhileWeb.IncomingWebhookRequestLiveTest do
  use StayAwhileWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected mount", %{conn: conn} do
    conn = get(conn, "/incoming-webhook-requests")

    assert html_response(conn, 200) =~ "<h1>Incoming webhook requests</h1>"
  end

  test "connected mount", %{conn: conn} do
    {:ok, view, html} = live(conn, "/incoming-webhook-requests")

    assert html =~ "<h1>Incoming webhook requests</h1>"
    assert render(view) =~ "<h1>Incoming webhook requests</h1>"

    send(view.pid, {:incoming_conn, %Plug.Conn{method: "POST"}})

    assert render(view) =~ "Method: POST"
  end
end
