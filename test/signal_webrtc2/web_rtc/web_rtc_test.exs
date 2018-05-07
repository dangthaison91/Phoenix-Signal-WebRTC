defmodule SignalWebrtc2.WebRTCTest do
  use SignalWebrtc2.DataCase

  alias SignalWebrtc2.WebRTC

  describe "rooms" do
    alias SignalWebrtc2.WebRTC.Room

    @valid_attrs %{code: "some code", email: [], name: "some name"}
    @update_attrs %{code: "some updated code", email: [], name: "some updated name"}
    @invalid_attrs %{code: nil, email: nil, name: nil}

    def room_fixture(attrs \\ %{}) do
      {:ok, room} =
        attrs
        |> Enum.into(@valid_attrs)
        |> WebRTC.create_room()

      room
    end

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert WebRTC.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert WebRTC.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      assert {:ok, %Room{} = room} = WebRTC.create_room(@valid_attrs)
      assert room.code == "some code"
      assert room.email == []
      assert room.name == "some name"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = WebRTC.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      assert {:ok, room} = WebRTC.update_room(room, @update_attrs)
      assert %Room{} = room
      assert room.code == "some updated code"
      assert room.email == []
      assert room.name == "some updated name"
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = WebRTC.update_room(room, @invalid_attrs)
      assert room == WebRTC.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = WebRTC.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> WebRTC.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = WebRTC.change_room(room)
    end
  end
end
