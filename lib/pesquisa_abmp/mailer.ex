defmodule PesquisaABMP.Mailer do
  @conf domain: Application.get_env(:pesquisa_abmp, :mailgun_domain),
    key: Application.get_env(:pesquisa_abmp, :mailgun_key)
  use Mailgun.Client, @conf

  @sender "pesquisa@pesquisaabmp.com.br"

  defp reset_email_text(empresa, senha) do
    """
    Prezado,

    Conforme solicitação, segue o seu usuário e senha para acesso à nossa pesquisa.

    Usuário: #{empresa.username}
    Senha: #{senha}

    Você pode fazer login utilizando os dados acima em https://pesquisaabmp.com.br

    Atenciosamente,

    Pesquisa ABMP
    """
  end

  def send_reset_email(empresa, senha) do
    send_email to: empresa.email1,
      from: @sender,
      subject: "Sua solicitação de senha - Pesquisa ABMP",
      text: reset_email_text(empresa, senha),
      html: Phoenix.View.render_to_string(PesquisaABMP.EmailView, "reset_password.html", %{empresa: empresa, senha: senha})
  end

  defp finished_survey_email_text(empresa) do
    """
    A empresa #{empresa.nome} acabou de concluir a pesquisa no sistema.

    Você pode conferir os dados da pesquisa concluída no painel administrativo.
    """
  end

  def finished_survey_email(conn, empresa) do
    send_email to: System.get_env("NOTIFICATION_EMAIL"),
      from: @sender,
      subject: "Pesquisa concluída - #{empresa.nome}",
      text: finished_survey_email_text(empresa),
      html: Phoenix.View.render_to_string(PesquisaABMP.EmailView, "finished_survey.html", %{empresa: empresa, conn: conn})
  end


end
