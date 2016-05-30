defmodule PesquisaABMP.EmpresaControllerTest do
  use PesquisaABMP.ConnCase

  alias PesquisaABMP.Empresa
  @valid_attrs %{cep: "some content", diretor1: "some content", diretor2: "some content", email1: "some content", email2: "some content", endereco: "some content", site: "some content", telefone: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, empresa_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing empresas"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, empresa_path(conn, :new)
    assert html_response(conn, 200) =~ "New empresa"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, empresa_path(conn, :create), empresa: @valid_attrs
    assert redirected_to(conn) == empresa_path(conn, :index)
    assert Repo.get_by(Empresa, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, empresa_path(conn, :create), empresa: @invalid_attrs
    assert html_response(conn, 200) =~ "New empresa"
  end

  test "shows chosen resource", %{conn: conn} do
    empresa = Repo.insert! %Empresa{}
    conn = get conn, empresa_path(conn, :show, empresa)
    assert html_response(conn, 200) =~ "Show empresa"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, empresa_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    empresa = Repo.insert! %Empresa{}
    conn = get conn, empresa_path(conn, :edit, empresa)
    assert html_response(conn, 200) =~ "Edit empresa"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    empresa = Repo.insert! %Empresa{}
    conn = put conn, empresa_path(conn, :update, empresa), empresa: @valid_attrs
    assert redirected_to(conn) == empresa_path(conn, :show, empresa)
    assert Repo.get_by(Empresa, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    empresa = Repo.insert! %Empresa{}
    conn = put conn, empresa_path(conn, :update, empresa), empresa: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit empresa"
  end

  test "deletes chosen resource", %{conn: conn} do
    empresa = Repo.insert! %Empresa{}
    conn = delete conn, empresa_path(conn, :delete, empresa)
    assert redirected_to(conn) == empresa_path(conn, :index)
    refute Repo.get(Empresa, empresa.id)
  end
end
