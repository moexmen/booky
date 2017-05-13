defmodule Booky.Router do
  use Booky.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticate do
    plug :authenticate_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Booky do
    pipe_through :browser # Use the default browser stack
    pipe_through :authenticate

    get "/", PageController, :index
  end

  scope "/auth", Booky do
    pipe_through :browser
    get "/", AuthController, :index
    post "/", AuthController, :create
    get "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  defp authenticate_user(conn, _) do
    current_user = get_session(conn, :current_user)
    if current_user do
      assign(conn, :current_user, current_user)
    else
      conn
        |> put_flash(:error, 'You need to login to view Booky')
        |> redirect(to: "/auth")
        |> halt
    end
  end
  # Other scopes may use custom stacks.
  # scope "/api", Booky do
  #   pipe_through :api
  # end
end
