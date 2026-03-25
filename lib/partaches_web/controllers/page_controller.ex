defmodule PartachesWeb.PageController do
  use PartachesWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
