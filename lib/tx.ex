defmodule Explora.Tx do
  @moduledoc """
  Documentation for `Explora.Tx`.
  """

  alias Explora.Tx.{In, Out, Status}

  defstruct [
    :txid,
    :version,
    :locktime,
    :vin,
    :vout,
    :size,
    :weight,
    :fee,
    :status,
    :network
  ]

  def decode(tx_json) do
    data = Poison.decode!(tx_json)
    %__MODULE__{
      txid: data["txid"],
      version: data["version"],
      locktime: data["locktime"],
      vin: decode_ins(data["vin"]),
      vout: decode_outs(data["vout"]),
      size: data["size"],
      weight: data["weight"],
      fee: data["fee"],
      status: Status.new(data["status"]),
      network: data["network"]
    }
  end

  def decode_ins(ins) do
    Enum.map(ins, fn input ->
      In.new(input)
    end)
  end

  def decode_outs(outs) do
    Enum.map(outs, fn output ->
      Out.new(output)
    end)
  end
end

defmodule Explora.Tx.In do

  defstruct [
    :txid,
    :vout,
    :is_coinbase,
    :script_sig,
    :sequence,
    :witnesses,
    :prevout
  ]

  def new(input) do
    if input["is_coinbase"] do
      %__MODULE__{
        txid: input["txid"],
        vout: input["vout"],
        is_coinbase: input["is_coinbase"],
        script_sig: input["script_sig"],
        sequence: input["sequence"]
      }
    else
      %__MODULE__{
        txid: input["txid"],
        vout: input["vout"],
        is_coinbase: input["is_coinbase"],
        script_sig: input["script_sig"],
        sequence: input["sequence"],
        witnesses: input["witnesses"],
        prevout: input["prevout"]
      }
    end
  end

  def decode(input) do
    input = Poison.decode!(input)
    new(input)
  end

end

defmodule Explora.Tx.Out do

  defstruct [
    :scriptpubkey,
    :scriptpubkey_type,
    :address,
    :value
  ]

  def new(output) do
    %__MODULE__{
      scriptpubkey: output["scriptpubkey"],
      scriptpubkey_type: output["scriptpubkey_type"],
      address: output["address"],
      value: output["value"]
    }
  end

  def decode(output) do
    output = Poison.decode!(output, keys: :atoms!)
    new(output)
  end
end

defmodule Explora.Tx.Status do

  alias Poison

  defstruct [
    :confirmed,
    :block_height,
    :block_hash,
    :block_time
  ]

  def new(status) do
    if status["confirmed"] do
      %__MODULE__{
        confirmed: status["confirmed"],
        block_height: status["block_height"],
        block_hash: status["block_hash"],
        block_time: status["block_time"]
      }
    else
      %__MODULE__{
        confirmed: status["confirmed"]
      }
    end
  end

  def decode(status) do
    status = Poison.decode!(status, keys: :atoms!)
    new(status)
  end
end
