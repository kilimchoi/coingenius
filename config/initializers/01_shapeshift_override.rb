ShapeShiftRuby::Client.class_eval do
  def fixed_amount_transaction(amount:,
    api_key: "",
    deposit_amount: false,
    dest_tag: "",
    pair:,
    payment_id: "",
    return_address: "",
    rs_address: "",
    withdrawal:)
    amount_params_key = deposit_amount ? "depositAmount" : "amount"

    params = {
      amount_params_key => amount,
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

  def quote_transaction(amount:, deposit_amount: false, pair:)
    amount_params_key = deposit_amount ? "depositAmount" : "amount"

    params = { amount_params_key => amount, pair: pair }

    api_request(url: url("sendamount"), method: "post", params: params)
  end
end
