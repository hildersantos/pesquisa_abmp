defmodule PesquisaABMP.QuestionarioControllerTest do
  use PesquisaABMP.ConnCase

  alias PesquisaABMP.Questionario
  @valid_attrs %{nome: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, questionario_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    questionario = Repo.insert! %Questionario{}
    conn = get conn, questionario_path(conn, :show, questionario)
    assert json_response(conn, 200)["data"] == %{"id" => questionario.id,
      "nome" => questionario.nome}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, questionario_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, questionario_path(conn, :create), questionario: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Questionario, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, questionario_path(conn, :create), questionario: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    questionario = Repo.insert! %Questionario{}
    conn = put conn, questionario_path(conn, :update, questionario), questionario: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Questionario, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    questionario = Repo.insert! %Questionario{}
    conn = put conn, questionario_path(conn, :update, questionario), questionario: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    questionario = Repo.insert! %Questionario{}
    conn = delete conn, questionario_path(conn, :delete, questionario)
    assert response(conn, 204)
    refute Repo.get(Questionario, questionario.id)
  end
end
