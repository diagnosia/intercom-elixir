defmodule Intercom.API.Request do
  @moduledoc false

  def make_request(:get, url, headers, nil) do
    http_adapter().get(url, headers)
    |> parse_response()
  end

  def make_request(:post, url, headers, body) do
    http_adapter().post(url, Jason.encode!(body), headers, [])
    |> parse_response()
  end

  def make_request(:delete, url, headers, nil) do
    http_adapter().delete(url, headers, [])
    |> parse_response()
  end

  defp parse_response({:ok, %HTTPoison.Response{} = response}) do
    body =
      case response.status_code do
        200 -> decode_body(response)
        _ -> {:error, response}
      end

    case body do
      {:ok, body} -> {:ok, response, body}
      {:error, response} -> {:error, response}
    end
  end

  defp parse_response({:error, error}), do: {:error, error}

  defp parse_response({:ok, response}) do
    {:error, response}
  end

  defp decode_body(%HTTPoison.Response{body: ""}), do: {:ok, %{}}

  defp decode_body(%HTTPoison.Response{body: body} = response) do
    case Jason.decode(body) do
      {:ok, json} ->
        {:ok, json}

      {:error, _} ->
        {:error, response}
    end
  end

  defp decode_body(nil), do: {:ok, %{}}

  defp http_adapter() do
    Application.get_env(:intercom, :http_adapter)
  end
end
