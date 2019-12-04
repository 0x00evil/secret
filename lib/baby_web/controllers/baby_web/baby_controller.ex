defmodule BabyWeb.BabyController do
  @aes_block_size 16


  use BabyWeb, :controller

  def index(conn, params) do
    iv = :base64.decode("WwjoHiCVNxBiWI6AhLmUsw==")
    mode = :aes_128_cbc
    secret_key = Base.decode64!(params["secret"]["key"])
    clear_text = params["secret"]["encode"]
    secret_text = params["secret"]["decode"]

    if clear_text == "" do
      plain_text = :crypto.block_decrypt(mode, secret_key, iv, Base.decode64!(secret_text))
      text(conn, unpad(plain_text))
    else
      cipher_text = :crypto.block_encrypt(mode, secret_key, iv, pad(clear_text, @aes_block_size))
      text(conn, Base.encode64(cipher_text))
    end
  end

  def pad(data, block_size) do
    to_add = block_size - rem(byte_size(data), block_size)
    data = data <> to_string(:string.chars(to_add, to_add))
    data
  end

  def unpad(data) do
    to_remove = :binary.last(data)
    :binary.part(data, 0, byte_size(data) - to_remove)
  end
end
