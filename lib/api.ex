defmodule Explora.API do
  require HTTPoison

  @base_url "https://blockstream.info/api/"
  @testnet_url "https://blockstream.info/testnet/api/"

  @status_code_200 200

  def post(endpoint, data, testnet \\ false) do
    url = if testnet do
      @testnet_url <> endpoint
    else
      @base_url <> endpoint
    end
    headers = [{"Content-Type", "application/json"}]
    case HTTPoison.post(url, data, headers) do
      {:ok, response = %HTTPoison.Response{status_code: @status_code_200}} ->
        {:ok, response.body}
      {:ok, response} ->
        {:error, response.body}
      {:error, error} ->
        {:error, error}
    end
  end

  def get(endpoint, testnet \\ false) do
    url = if testnet do
      @testnet_url <> endpoint
    else
      @base_url <> endpoint
    end
    headers = [{"Content-Type", "application/json"}]
    case HTTPoison.get(url, headers) do
      {:ok, response = %HTTPoison.Response{status_code: @status_code_200}} ->
        {:ok, response.body}
      {:ok, response} ->
        {:error, response.body}
      {:error, error} ->
        {:error, error}
    end
  end




end
