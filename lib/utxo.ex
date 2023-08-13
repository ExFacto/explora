defmodule Explora.UTXO do
  defstruct [
    :txid,
    :vout,
    :status,
    :value
  ]

  alias Explora.Tx.Status

  def new(utxo) do
    %__MODULE__{
      txid: utxo["txid"],
      vout: utxo["vout"],
      status: Status.new(utxo["status"]),
      value: utxo["value"]
    }
  end

  def decode(utxo_json) do
    utxo = Poison.decode!(utxo_json)
    new(utxo)
  end

  def decode_utxos(utxos_json) do
    utxos = Poison.decode!(utxos_json)
    Enum.map(utxos, fn utxo ->
      new(utxo)
    end)
  end
end

defmodule Explora.Outpoint do
  alias Explora.Tx.Status

  defstruct [
    :spent,
    :txid,
    :vin,
    :status
  ]

  def new(outpoint) do
    if outpoint["spent"] do
      %__MODULE__{
        spent: true,
        txid: outpoint["txid"],
        vin: outpoint["vin"],
        status: Status.new(outpoint["status"])
      }
    else
      %__MODULE__{
        spent: false,
      }
    end
  end

  def decode(outpoint_json) do
    outpoint = Poison.decode!(outpoint_json)
    new(outpoint)
  end
end
