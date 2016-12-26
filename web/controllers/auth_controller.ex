defmodule Booky.AuthController do
  use Booky.Web, :controller

  @doc """
  This action is reached via `/auth/` and redirects to GitHub
  """
  def index(conn, _params) do
    redirect conn, external: authorize_url!("github")
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  @doc """
  This action is reached via `/auth/:provider/callback` is the the callback URL that
  the OAuth2 provider will redirect the user back to with a `code` that will
  be used to request an access token. The access token will then be used to
  access protected resources on behalf of the user.

  The URL is configured in the provider's app config.
  """
  def callback(conn, %{"provider" => provider, "code" => code}) do
    # Exchange an auth code for an access token
    client = get_token!(provider, code)

    # Request the user's data with the access token
    user = get_user!(provider, client)

    # Check if user belongs to the approved org
    if belong_to_github_org(client) do
      # Store the user in the session under `:current_user` and redirect to /.
      # In most cases, we'd probably just store the user's ID that can be used
      # to fetch from the database. In this case, since this example app has no
      # database, I'm just storing the user map.
      #
      # If you need to make additional resource requests, you may want to store
      # the access token as well.
      conn
      |> put_session(:current_user, user)
      |> put_session(:access_token, client.token.access_token)
      |> redirect(to: "/?success")
    else
      conn
      |> put_flash(:error, "You do not belong to the organization.")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end


  # Ask for permission to read the organizations of the user
  # See https://developer.github.com/v3/oauth/#scopes
  defp authorize_url!("github"), do: GitHub.authorize_url!(scope: "read:org")
  defp get_token!("github", code), do: GitHub.get_token!(code: code)
  defp get_user!("github", client) do
    %{body: user} = OAuth2.Client.get!(client, "/user")
    %{name: user["name"], avatar: user["avatar_url"], username: user["login"]}
  end
  defp belong_to_github_org(client) do
    # Check if the user belongs to the organization
    org_name = Application.get_env(:booky, GitHub)[:organization]
    %{body: organizations} = OAuth2.Client.get!(client, "/user/memberships/orgs/#{org_name}")

    case organizations do
      # Belongs to the organization
      %{"organization" => _} -> true
      # This is what the GitHub API returns when it cannot find membership information
      %{"documentation_url" => _, "message" => _} -> false
    end
  end
end
