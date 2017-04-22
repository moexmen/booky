defmodule Booky.Plug.AuthenticateUser do
  import Plug.Conn
  import Booky.Router.Helpers
  import Phoenix.Controller

  def init(default), do: default

  def call(conn, _default) do
    current_user = get_session(conn, :current_user)
    if current_user do
      assign(conn, :current_user, current_user)
    else
      conn
        |> put_flash(:error, 'You need to login in to view Booky')
        |> redirect(to: auth_path(conn, :index))
        |> halt
    end
  end
end
