defmodule Explora.UTXO do
  defstruct [
    :txid,
    :vout,
    :status,
    :value
  ]

  alias Explora.Tx.Status

  def decode(utxo_json) do
    utxo = Poison.decode!(utxo_json, keys: :atoms!)
    %__MODULE__{
      txid: utxo.txid,
      vout: utxo.vout,
      status: utxo.status,
      value: utxo.value
    }
  end

  def decode_utxos(utxos_json) do
    utxos = Poison.decode!(utxos_json)
    Enum.map(utxos, fn utxo ->
      %__MODULE__{
        txid: utxo["txid"],
        vout: utxo["vout"],
        status: Status.new(utxo["status"]),
        value: utxo["value"]
      }
    end)
  end
end

defmodule Explora.Outpoint do
  alias Explora.Tx.Status

  defstruct [
    :spent,
    :txid,
    :vout,
    :status
  ]
  def decode(outpoint_json) do
    outpoint = Poison.decode!(outpoint_json, keys: :atoms!)
    if outpoint.spent do
      %__MODULE__{
        spent: true,
        txid: outpoint.txid,
        vout: outpoint.vin,
        status: Status.new(outpoint.status)
      }
    else
      %__MODULE__{
        spent: false,
      }
    end
  end
end
