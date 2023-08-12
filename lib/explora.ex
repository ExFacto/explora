defmodule Explora do
  @moduledoc """
  Documentation for `Explora`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Explora.hello()
      :world

  """
  alias Explora.{API, Block, Tx, Fee, UTXO}

  # BLOCKS

  def get_block(hash, testnet \\ false) do
    resp = API.get("block/#{hash}", testnet)
    case resp do
      {:ok, block_json} ->
        {:ok, Block.decode(block_json)}
      {:error, err} ->
        {:error, "Could not get block: #{hash}: #{err}"}
    end
  end

  def get_block_by_height(height, testnet \\ false) do
    resp = API.get("block-height/#{height}", testnet)
    case resp do
      {:ok, hash} ->
        get_block(hash, testnet)
      {:error, err} ->
        {:error, "Could not get block by height: #{height}: #{err}"}
    end
  end

  # TRANSACTIONS

  def get_tx(txid, testnet \\ false) do
    resp = API.get("tx/#{txid}", testnet)
    case resp do
      {:ok, tx_json} ->
        {:ok, Tx.decode(tx_json)}
      {:error, err} ->
        {:error, "Could not get transaction: #{txid}: #{err}"}
    end
  end

  def post_tx(tx_hex, testnet \\ false) do
    resp = API.post("tx", tx_hex, testnet)
    case resp do
      {:ok, txid} ->
        {:ok, txid}
      {:error, err} ->
        {:error, "Could not post transaction: #{tx_hex}: #{err}"}
    end
  end

  # UTXOs

  def get_address_utxos(address, testnet \\ false) do
    resp = API.get("address/#{address}/utxo", testnet)
    case resp do
      {:ok, utxo_json} ->
        {:ok, UTXO.decode_utxos(utxo_json)}
      {:error, err} ->
        {:error, "Could not get UTXO for address: #{address}: #{err}"}
    end
  end

  # FEES


  def get_fee_estimates(testnet \\ false) do
    resp = API.get("fee-estimates", testnet)
    case resp do
      {:ok, fee_json} ->
        {:ok, Fee.decode(fee_json)}
      {:error, err} ->
        {:error, "Could not get fee estimates: #{err}"}
    end
  end

end
