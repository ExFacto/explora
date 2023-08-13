defmodule Explora.Block do

  defstruct [
    :id,
    :height,
    :version,
    :timestamp,
    :tx_count,
    :size,
    :weight,
    :merkle_root,
    :previousblockhash,
    :mediantime,
    :nonce,
    :bits,
    :difficulty
  ]

  def decode(block_json) do
    block = Poison.decode!(block_json)
    %__MODULE__{
      id: block["id"],
      height: block["height"],
      version: block["version"],
      timestamp: block["timestamp"],
      tx_count: block["tx_count"],
      size: block["size"],
      weight: block["weight"],
      merkle_root: block["merkle_root"],
      previousblockhash: block["previousblockhash"],
      mediantime: block["mediantime"],
      nonce: block["nonce"],
      bits: block["bits"],
      difficulty: block["difficulty"]
    }
  end
end
