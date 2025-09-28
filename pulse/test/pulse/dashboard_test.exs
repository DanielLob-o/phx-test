defmodule Pulse.DashboardTest do
  use Pulse.DataCase

  alias Pulse.Dashboard

  describe "events" do
    alias Pulse.Dashboard.Event

    import Pulse.DashboardFixtures

    @invalid_attrs %{event_text: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Dashboard.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Dashboard.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{event_text: "some event_text"}

      assert {:ok, %Event{} = event} = Dashboard.create_event(valid_attrs)
      assert event.event_text == "some event_text"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{event_text: "some updated event_text"}

      assert {:ok, %Event{} = event} = Dashboard.update_event(event, update_attrs)
      assert event.event_text == "some updated event_text"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboard.update_event(event, @invalid_attrs)
      assert event == Dashboard.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Dashboard.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Dashboard.change_event(event)
    end
  end
end
