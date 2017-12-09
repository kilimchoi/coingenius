ShapeShiftRuby::Client.class_eval do
  def fixed_amount_transaction(amount:,
                               api_key: "",
                               dest_tag: "",
                               pair:,
                               payment_id: "",
                               return_address: "",
                               rs_address: "",
                               withdrawal:)
    params = {
      amount: amount,
      apiKey: api_key,
      destTag: dest_tag,
      pair: pair,
      paymentId: payment_id,
      returnAddress: return_address,
      rsAddress: rs_address,
      withdrawal: withdrawal
    }

    api_request(url: url("sendamount"), method: "post", params: params)
  end
end
