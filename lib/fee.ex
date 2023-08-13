defmodule Explora.Fee do
  defstruct [
    :blocks_2,
    :blocks_3,
    :blocks_4,
    :blocks_6,
    :blocks_10,
    :blocks_20,
    :blocks_144,
    :blocks_504,
    :blocks_1008
  ]

  def new(fee) do
    %__MODULE__{
      blocks_2: fee["2"],
      blocks_3: fee["3"],
      blocks_4: fee["4"],
      blocks_6: fee["6"],
      blocks_10: fee["10"],
      blocks_20: fee["20"],
      blocks_144: fee["144"],
      blocks_504: fee["504"],
      blocks_1008: fee["1008"]
    }
  end

  def decode(fee_json) do
    fee = Poison.decode!(fee_json)
    new(fee)
  end
end
