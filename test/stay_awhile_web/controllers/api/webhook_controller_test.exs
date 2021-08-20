defmodule StayAwhileWeb.API.WebhookControllerTest do
  use StayAwhileWeb.ConnCase, async: true

  describe "POST /api/webhook" do
    test "broadcasts conn on webhook topic and returns 200", %{conn: conn} do
      @endpoint.subscribe("webhook:123")
      params = %{"id" => "123"}

      conn = post(conn, "/api/webhook/123", params)

      assert_receive {:incoming_conn, %Plug.Conn{method: "POST", body_params: ^params}}
      assert conn.status == 200
    end
  end
end
