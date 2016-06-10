defmodule PesquisaABMP.DadosEmpresaControllerTest do
  use PesquisaABMP.ConnCase

  alias PesquisaABMP.DadosEmpresa
  @valid_attrs %{endereco: "some content", facebook: "some content", filial: "some content", instagram: "some content", nome: "some content", num_func_homens: 42, num_func_mulheres: 42, num_funcionarios: 42, num_socios: 42, site: "some content", telefone: "some content", tempo_atividade: 42, twitter: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, dados_empresa_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing dados empresas"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, dados_empresa_path(conn, :new)
    assert html_response(conn, 200) =~ "New dados empresa"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, dados_empresa_path(conn, :create), dados_empresa: @valid_attrs
    assert redirected_to(conn) == dados_empresa_path(conn, :index)
    assert Repo.get_by(DadosEmpresa, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, dados_empresa_path(conn, :create), dados_empresa: @invalid_attrs
    assert html_response(conn, 200) =~ "New dados empresa"
  end

  test "shows chosen resource", %{conn: conn} do
    dados_empresa = Repo.insert! %DadosEmpresa{}
    conn = get conn, dados_empresa_path(conn, :show, dados_empresa)
    assert html_response(conn, 200) =~ "Show dados empresa"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, dados_empresa_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    dados_empresa = Repo.insert! %DadosEmpresa{}
    conn = get conn, dados_empresa_path(conn, :edit, dados_empresa)
    assert html_response(conn, 200) =~ "Edit dados empresa"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    dados_empresa = Repo.insert! %DadosEmpresa{}
    conn = put conn, dados_empresa_path(conn, :update, dados_empresa), dados_empresa: @valid_attrs
    assert redirected_to(conn) == dados_empresa_path(conn, :show, dados_empresa)
    assert Repo.get_by(DadosEmpresa, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    dados_empresa = Repo.insert! %DadosEmpresa{}
    conn = put conn, dados_empresa_path(conn, :update, dados_empresa), dados_empresa: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit dados empresa"
  end

  test "deletes chosen resource", %{conn: conn} do
    dados_empresa = Repo.insert! %DadosEmpresa{}
    conn = delete conn, dados_empresa_path(conn, :delete, dados_empresa)
    assert redirected_to(conn) == dados_empresa_path(conn, :index)
    refute Repo.get(DadosEmpresa, dados_empresa.id)
  end
end
