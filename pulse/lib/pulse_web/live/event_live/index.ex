# lib/pulse_web/live/event_live/index.ex

defmodule PulseWeb.EventLive.Index do
  use PulseWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    # 1. When the page loads, subscribe this LiveView process to the "events" topic.
    if connected?(socket), do: Phoenix.PubSub.subscribe(Pulse.PubSub, "events")

    # 2. Initialize the page with an empty list of events.
    socket = assign(socket, :events, [])
    {:ok, socket}
  end

  # 3. This is the event handler. It fires when a message we subscribed to is received.
  @impl true
  def handle_info(%{event: "new_event", payload: new_event}, socket) do
    # Add the new event to the beginning of our list of events.
    updated_events = [new_event | socket.assigns.events]

    # Put the updated list back into the socket and Phoenix re-renders the page.
    socket = assign(socket, :events, updated_events)
    {:noreply, socket}
  end

  # A catch-all for any other messages we don't care about.
  def handle_info(_message, socket) do
    {:noreply, socket}
  end
end
