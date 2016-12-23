defmodule Booky.PageController do
  use Booky.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
