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
    :previous_block_hash,
    :nonce,
    :bits
  ]

  def decode(block_json) do
    block = Poison.decode!(block_json, keys: :atoms!)
    %__MODULE__{
      id: block.id,
      height: block.height,
      version: block.version,
      timestamp: block.timestamp,
      tx_count: block.tx_count,
      size: block.size,
      weight: block.weight,
      merkle_root: block.merkle_root,
      previous_block_hash: block.previous_block_hash,
      nonce: block.nonce,
      bits: block.bits
    }
  end
end
