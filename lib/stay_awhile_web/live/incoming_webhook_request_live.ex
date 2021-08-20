defmodule StayAwhileWeb.IncomingWebhookRequestLive do
  use StayAwhileWeb, :live_view

  @impl true
  def mount(%{"lobby_id" => lobby_id}, _, socket) do
    if connected?(socket) do
      topic = "webhook:#{lobby_id}"
      :ok = Phoenix.PubSub.subscribe(StayAwhile.PubSub, topic)
    end

    {:ok, assign(socket, conns: [], lobby_id: lobby_id)}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <h1>Incoming webhook requests of Lobby <%= @lobby_id %></h1>
    <%= for conn <- @conns do %>
      <pre>
        <code>
          Host: <%= conn.host %>

          Method: <%= conn.method %>

          Remote IP: <%= inspect(conn.remote_ip) %>

          Headers: <%= inspect(conn.req_headers) %>

          Body Params: <%= inspect(conn.body_params) %>
        </code>
      </pre>
    <% end %>
    """
  end

  @impl true
  def handle_info({:incoming_conn, %Plug.Conn{} = conn}, socket) do
    {:noreply, update(socket, :conns, fn conns -> [conn | conns] end)}
  end
end
