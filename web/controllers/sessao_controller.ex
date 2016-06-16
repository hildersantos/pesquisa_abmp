defmodule PesquisaABMP.SessaoController do
  use PesquisaABMP.Web, :controller

  plug :scrub_params, "reset_password" when action in [:reset_password_handler]

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"sessao" => %{"username" => user, "password" => pass}}) do
    case PesquisaABMP.Auth.login_by_username_and_pass(conn, user, pass, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Bem vindo!")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Combinação inválida de usuário/senha")
        |> render("new.html")
    end
  end

  def reset_password(conn, _) do
    render conn, "reset.html"
  end

  def reset_password_handler(conn, %{"reset_password" => %{"username" => username}}) do
    unless is_nil(username) do
      empresa = Repo.get_by(PesquisaABMP.Empresa, [username: username])

      case empresa do
        nil ->
          nil
        empresa ->
          new_pass = :crypto.strong_rand_bytes(8) |> Base.encode64 |> binary_part(0, 8)
          changeset = PesquisaABMP.Empresa.changeset(empresa, %{password: new_pass})

          case Repo.update(changeset) do
            {:ok, empresa} ->
              PesquisaABMP.Mailer.send_reset_email(empresa, new_pass)
            {:error, _} ->
              nil
          end
      end

      conn
      |> put_flash(:info, "Se o nome de usuário '#{username}' corresponder a um usuário cadastrado, você receberá um email contendo informações de como fazer login no sistema. Por favor, confira seu email, incluindo a caixa de spam.")
      |> redirect(to: sessao_path(conn, :new))
  else
    conn
    |> put_flash(:error, "Insira um nome de usuário")
    |> render("reset.html")
    end
  end

  def delete(conn, _) do
    conn
    |> PesquisaABMP.Auth.logout()
    |> redirect(to: page_path(conn, :index))
  end
end
