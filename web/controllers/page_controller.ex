defmodule Booky.PageController do
  use Booky.Web, :controller
  plug Booky.Plug.AuthenticateUser

  def index(conn, _params) do
    render conn, "index.html"
  end
end
