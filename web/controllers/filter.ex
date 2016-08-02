defmodule PesquisaABMP.QueryFilter do
  import Ecto.Query, only: [where: 2]

  def filter(query, model, params, filters) do
    where_clauses = cast(model, params, filters)

    query
    |> where(^where_clauses)
  end

  defp cast(model, params, filters) do
    Ecto.Changeset.cast(model, params, [], filters)
    |> Map.fetch!(:changes)
    |> Map.to_list
  end
end
