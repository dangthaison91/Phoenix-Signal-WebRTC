defmodule SignalWebrtc2Web.RoomControllerTest do
  use SignalWebrtc2Web.ConnCase

  alias SignalWebrtc2.WebRTC
  alias SignalWebrtc2.WebRTC.Room

  @create_attrs %{code: "some code", email: [], name: "some name"}
  @update_attrs %{code: "some updated code", email: [], name: "some updated name"}
  @invalid_attrs %{code: nil, email: nil, name: nil}

  def fixture(:room) do
    {:ok, room} = WebRTC.create_room(@create_attrs)
    room
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all rooms", %{conn: conn} do
      conn = get conn, room_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create room" do
    test "renders room when data is valid", %{conn: conn} do
      conn = post conn, room_path(conn, :create), room: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, room_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "code" => "some code",
        "email" => [],
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, room_path(conn, :create), room: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update room" do
    setup [:create_room]

    test "renders room when data is valid", %{conn: conn, room: %Room{id: id} = room} do
      conn = put conn, room_path(conn, :update, room), room: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, room_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "code" => "some updated code",
        "email" => [],
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, room: room} do
      conn = put conn, room_path(conn, :update, room), room: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete room" do
    setup [:create_room]

    test "deletes chosen room", %{conn: conn, room: room} do
      conn = delete conn, room_path(conn, :delete, room)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, room_path(conn, :show, room)
      end
    end
  end

  defp create_room(_) do
    room = fixture(:room)
    {:ok, room: room}
  end
end
