defmodule SignalWebrtc2Web.RoomController do
  use SignalWebrtc2Web, :controller

  alias SignalWebrtc2.WebRTC
  alias SignalWebrtc2.WebRTC.Room

  action_fallback(SignalWebrtc2Web.FallbackController)

  def index(conn, params) do
    rooms = WebRTC.list_rooms(params)
    render(conn, "index.json", rooms: rooms)
  end

  def create(conn, %{"room" => room_params}) do
    code = Ecto.UUID.generate() |> String.slice(0, 8)
    room_params = Map.put(room_params, "code", code)

    with {:ok, %Room{} = room} <- WebRTC.create_room(room_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", room_path(conn, :show, room))
      |> render("show.json", room: room)
    end

    # with {:ok, %Room{} = room} <- WebRTC.create_room(room_params) do
    #   conn
    #   |> put_status(:created)
    #   |> put_resp_header("location", room_path(conn, :show, room))
    #   |> render("show.json", room: room)
    # end
  end

  def show(conn, %{"id" => id}) do
    room = WebRTC.get_room!(id)
    render(conn, "show.json", room: room)
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = WebRTC.get_room!(id)

    with {:ok, %Room{} = room} <- WebRTC.update_room(room, room_params) do
      render(conn, "show.json", room: room)
    end
  end

  def delete(conn, %{"id" => id}) do
    room = WebRTC.get_room!(id)

    with {:ok, %Room{}} <- WebRTC.delete_room(room) do
      send_resp(conn, :no_content, "")
    end
  end
end
