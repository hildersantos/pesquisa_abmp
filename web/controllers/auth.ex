defmodule PesquisaABMP.Auth do
  import Plug.Conn
  import Phoenix.Controller
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias PesquisaABMP.Router.Helpers

  @default_fail_message "Você não tem permissão de ver esta página"

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user = user_id && repo.get(PesquisaABMP.Empresa, user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def login_by_username_and_pass(conn, username, given_pass, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(PesquisaABMP.Empresa, username: username)

    cond do
      user && checkpw(given_pass, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> failed_redirect("Você precisa estar logado para ver esta página")
    end
  end

  def only_admins(conn, _opts) do
    if conn.assigns.current_user && conn.assigns.current_user.is_admin do
      conn
    else
      conn
      |> failed_redirect()
    end
  end

  defp failed_redirect(conn, message \\ @default_fail_message) do
    conn
    |> put_flash(:error, message)
    |> redirect(to: Helpers.page_path(conn, :index))
    |> halt()
  end
end
