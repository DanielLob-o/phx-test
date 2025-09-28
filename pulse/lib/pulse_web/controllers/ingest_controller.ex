defmodule PulseWeb.IngestController do
  use PulseWeb, :controller

  alias Pulse.PubSub

  def create(conn, params) do
    # 2. This is the magic! Broadcast the received data.
    #    Topic: "events"
    #    Event Name: "new_event"
    #    Payload: The map of parameters we received
    Phoenix.PubSub.broadcast(PubSub, "events", %{event: "new_event", payload: params})

    # 3. Send a simple "OK" response
    json(conn, %{status: "ok"})
  end
end
