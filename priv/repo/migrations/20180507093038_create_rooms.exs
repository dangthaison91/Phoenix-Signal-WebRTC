defmodule SignalWebrtc2.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :code, :string
      add :name, :string
      add :emails, {:array, :string}

      timestamps()
    end

  end
end
