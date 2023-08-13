defmodule ExploraTest do
  use ExUnit.Case
  doctest Explora

  alias Explora.{API, Block, Tx, Fee, UTXO, Outpoint}

  @block %Block{
    id: "000000000000000000026d15f33764be84855e32d8ea6d73efa4c0a521b1976a",
    height: 803000,
    version: 536870912,
    timestamp: 1691954926,
    tx_count: 3660,
    size: 1725762,
    weight: 3993411,
    merkle_root: "78b8e206a1380f34c072392c1b19547c5ebc46f9d7fb6228f205dcca799a3a46",
    previousblockhash: "000000000000000000002866bbda9fc1e51255afca3958eda0c17ccb4653c6b0",
    mediantime: 1691953229,
    nonce: 2379108647,
    bits: 386228059,
    difficulty: 52391178981379
  }

  test "get_block" do
    {:ok, block} = Explora.get_block(@block.id)
    assert @block == block
  end

  test "get_block_by_height" do
    {:ok, block} = Explora.get_block_by_height(@block.height)
    assert @block == block
  end

  test "get_tx" do
    {:ok, tx} = Explora.get_tx("95e48ab061576574b95e6e56936153e0f6286275261a3fa2d4b8c3ef188d8561")
    c_tx = %Explora.Tx{
      txid: "95e48ab061576574b95e6e56936153e0f6286275261a3fa2d4b8c3ef188d8561",
      version: 2,
      locktime: 0,
      vin: [
        %Explora.Tx.In{
          txid: "8e3f0307ef91249f1ebf97a9482ed9db60d430d0320b85f9e06a89aeea17479e",
          vout: 1,
          is_coinbase: false,
          script_sig: nil,
          sequence: 4294967293,
          witnesses: nil,
          prevout: %{
            "scriptpubkey" => "76a9149aa68156824b641fa588d28bae0aaca37ac74b0488ac",
            "scriptpubkey_address" => "1F6iXXcbndgBM5YmJ7jzBNKETGj4NGc2Lp",
            "scriptpubkey_asm" => "OP_DUP OP_HASH160 OP_PUSHBYTES_20 9aa68156824b641fa588d28bae0aaca37ac74b04 OP_EQUALVERIFY OP_CHECKSIG",
            "scriptpubkey_type" => "p2pkh",
            "value" => 5182881
          }
        }
      ],
      vout: [
        %Explora.Tx.Out{
          scriptpubkey: "0014336164eaa87264165b6ce042a3749e4436ddd8d5",
          scriptpubkey_type: "v0_p2wpkh",
          address: nil,
          value: 238601
        },
        %Explora.Tx.Out{
          scriptpubkey: "76a9149aa68156824b641fa588d28bae0aaca37ac74b0488ac",
          scriptpubkey_type: "p2pkh",
          address: nil,
          value: 4918495
        }
      ],
      size: 223,
      weight: 892,
      fee: 25785,
      status: %Explora.Tx.Status{
        confirmed: true,
        block_height: 803000,
        block_hash: "000000000000000000026d15f33764be84855e32d8ea6d73efa4c0a521b1976a",
        block_time: 1691954926
      },
      network: nil
    }
    assert c_tx == tx
  end

  # TODO: test "post_tx"
  # get mempool tx, repost, check txid.


  test "get_outpoint" do
    # unspent
    {:ok, outpoint} = Explora.get_outpoint("4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b", 0)
    assert !outpoint.spent

    # spent
    {:ok, outpoint} = Explora.get_outpoint("ba98eb9e8e1e1470cb633002bea98ee37fcb8929777f31c6676de5deb2c1bb83", 0)
    c_outpoint = %Outpoint{
      spent: true,
      txid: "73ebf6c0567d04e67ec1ca4cac191e77631205db542d6b8589585787ced936a0",
      vin: 0,
      status: %Tx.Status{
        confirmed: true,
        block_height: 803000,
        block_time: 1691954926,
        block_hash: "000000000000000000026d15f33764be84855e32d8ea6d73efa4c0a521b1976a"
      }
    }
    assert c_outpoint == outpoint
  end


  # test "get_address_utxos" do
  #   {:ok, utxos} = Explora.get_address_utxos("1LfbNHdFEUVDVZkstotJ2woA2eNnDJzENa")
  #   c_utxos = [
  #     %UTXO{
  #       txid: "818db471fa321d429da0963479f752b4c27ef363141a3ddd08766ac2fbedcf6a",
  #       vout: 0,
  #       status: %Tx.Status{
  #         confirmed: true,
  #         block_height: 450000,
  #         block_time: 1485382289,
  #         block_hash: "0000000000000000014083723ed311a461c648068af8cef8a19dcd620c07a20b"
  #       },
  #       value: 01021519
  #     }
  #   ]
  #   assert c_utxos == utxos
  # end

  test "get_fee_estimates" do
    {:ok, %Fee{}} = Explora.get_fee_estimates
  end
end
