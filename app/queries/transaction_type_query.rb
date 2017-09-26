class TransactionTypeQuery
  #TODO: Fix this as per Timur's comment.
  def initialize(relation)
    @relation = relation
  end

  def all
    @relation.where(is_expired: false).order(:transaction_type).includes(:coin)
  end
end


