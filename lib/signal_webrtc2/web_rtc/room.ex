defmodule SignalWebrtc2.WebRTC.Room do
  use Ecto.Schema
  import Ecto.Changeset


  schema "rooms" do
    field :code, :string
    field :emails, {:array, :string}
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:code, :name, :emails])
    |> validate_required([:code, :name, :emails])
  end
end
