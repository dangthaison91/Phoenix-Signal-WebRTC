defmodule SignalWebrtc2Web.Router do
  use SignalWebrtc2Web, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", SignalWebrtc2Web do
    pipe_through(:api)

    resources("/rooms", RoomController, except: [:new, :edit])
  end
end
