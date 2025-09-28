defmodule Pulse.DashboardFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pulse.Dashboard` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        event_text: "some event_text"
      })
      |> Pulse.Dashboard.create_event()

    event
  end
end
