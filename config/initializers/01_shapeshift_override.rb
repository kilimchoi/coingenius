ShapeShiftRuby::Client.class_eval do
  def shift(
    withdrawal:,
    pair:,
    return_address: "",
    dest_tag: "",
    rs_address: "",
    api_key: "",
    payment_id: nil
  )
    api_request(url: url("shift"), method: "post", params: {
                  pair: pair,
                  withdrawal: withdrawal,
                  returnAddress: return_address,
                  destTag: dest_tag,
                  rsAddress: rs_address,
                  paymentId: payment_id,
                  apiKey: api_key
                })
  end
end
