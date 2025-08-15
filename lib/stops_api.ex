defmodule StopsAPI do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/stops/:paragem" do
    case get_stops(paragem) do
      {:ok, result} ->
        send_json(conn, 200, result)

      {:error, _reason} ->
        send_json(conn, 500, %{error: "Failed to fetch stops"})
    end
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end

  defp send_json(conn, status, data) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Jason.encode!(data))
  end

  defp get_stops(paragem) do
    url =
      "https://www.stcp.pt/pt/widget/post.php?uid=d72242190a22274321cacf9eadc7ec5f&paragem=#{paragem}"

    with {:ok, %{status_code: 200, body: body}} <-
           HTTPoison.get(url, [], hackney: [insecure: true]),
         {:ok, stops_lines} <- parse_stops(body) do
      {:ok, batch_stops(stops_lines)}
    else
      {:ok, %{status_code: code}} -> {:error, "HTTP #{code}"}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
      error -> error
    end
  end

  defp parse_stops(html) do
    with {:ok, document} <- Floki.parse_document(html) do
      stops_lines =
        document
        |> Floki.find("div.floatLeft")
        |> Enum.filter(&has_linha_class?/1)
        |> Enum.map(&Floki.text/1)

      {:ok, stops_lines}
    end
  rescue
    e -> {:error, e}
  end

  defp has_linha_class?({_tag, attributes, _children}) do
    case List.keyfind(attributes, "class", 0) do
      {"class", class_string} -> String.contains?(class_string, "Linha")
      nil -> false
    end
  end

  defp batch_stops(stops_lines) do
    stops_lines
    |> Enum.drop(3)
    |> Enum.chunk_every(3)
  end
end

defmodule StopsAPI.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: StopsAPI, options: [port: 4000]}
    ]

    opts = [strategy: :one_for_one, name: StopsAPI.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
