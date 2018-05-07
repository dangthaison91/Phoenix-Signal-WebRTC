defmodule SignalWebrtc2.WebRTC do
  @moduledoc """
  The WebRTC context.
  """

  import Ecto.Query, warn: false
  alias SignalWebrtc2.Repo

  alias SignalWebrtc2.WebRTC.Room

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_rooms(params \\ %{}) do
    Room
    |> Room.filter(params)
    |> Repo.all()
  end

  @doc """
  Gets a single room.

  Raises `Ecto.NoResultsError` if the Room does not exist.

  ## Examples

      iex> get_room!(123)
      %Room{}

      iex> get_room!(456)
      ** (Ecto.NoResultsError)

  """
  def get_room!(id), do: Repo.get!(Room, id)

  @doc """
  Gets a single room by code and email

  Raises `Ecto.NoResultsError` if the Room does not exist.

  ## Examples

      iex> get_room!("ABCXYZ", "example@email.com")
      %Room{}

      iex> get_room!("A1", "example@email.com")
      ** (Ecto.NoResultsError)

  """
  def get_room!(code, email) do
    IO.inspect(code)

    query =
      from(
        r in Room,
        where: r.code == ^code,
        select: r
      )

    # Repo.get_by!(Room, code: code)
    Repo.one!(query)
  end

  @doc """
  Creates a room.

  ## Examples

      iex> create_room(%{field: value})
      {:ok, %Room{}}

      iex> create_room(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_room(attrs \\ %{}) do
    %Room{}
    |> Room.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a room.

  ## Examples

      iex> update_room(room, %{field: new_value})
      {:ok, %Room{}}

      iex> update_room(room, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Room.

  ## Examples

      iex> delete_room(room)
      {:ok, %Room{}}

      iex> delete_room(room)
      {:error, %Ecto.Changeset{}}

  """
  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking room changes.

  ## Examples

      iex> change_room(room)
      %Ecto.Changeset{source: %Room{}}

  """
  def change_room(%Room{} = room) do
    Room.changeset(room, %{})
  end
end
