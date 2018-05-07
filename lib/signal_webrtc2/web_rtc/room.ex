defmodule SignalWebrtc2.WebRTC.Room do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "rooms" do
    field(:code, :string)
    field(:emails, {:array, :string})
    field(:name, :string)

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:code, :name, :emails])
    |> validate_required([:code, :name, :emails])
  end

  def filter(query, params) do
    Enum.reduce(params, query, fn
      {"email", email}, query ->
        query |> where([r], ^email in r.emails)

      {_, _}, query ->
        query
    end)
  end
end
