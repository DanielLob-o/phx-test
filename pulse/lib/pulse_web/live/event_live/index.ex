# lib/pulse_web/live/event_live/index.ex

defmodule PulseWeb.EventLive.Index do
  use PulseWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    # 1. When the page loads, subscribe this LiveView process to the "events" topic.
    if connected?(socket), do: Phoenix.PubSub.subscribe(Pulse.PubSub, "events")

    # 2. Initialize the page with an empty list of events.
    # Initialize an empty stream for events and set an empty state assign.
    # Streams are the idiomatic way to handle collections in LiveView.
    socket =
      socket
      |> stream(:events, [])
      |> assign(:events_empty?, true)

    {:ok, socket}
  end

  # 3. This is the event handler. It fires when a message we subscribed to is received.
  @impl true
  def handle_info(%{event: "new_event", payload: new_event_params}, socket) do
# 1. Convert string keys in the payload to atom keys.
    event_data =
      Enum.into(new_event_params, %{}, fn {key, value} -> {String.to_atom(key), value} end)

    # 2. Add the unique :id atom key required for the stream.
    event_with_id = Map.put(event_data, :id, "event-#{System.unique_integer([:positive])}")

    # Insert the new event at the top of the stream.
    # We also update our empty? assign.
    socket =
      socket
      |> stream_insert(:events, event_with_id, at: 0)
      |> assign(:events_empty?, false)

    {:noreply, socket}
  end

  # A catch-all for any other messages we don't care about.
  def handle_info(_message, socket) do
    {:noreply, socket}
  end
end
