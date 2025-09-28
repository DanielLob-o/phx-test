defmodule Pulse.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :event_text, :string

      timestamps(type: :utc_datetime)
    end
  end
end
