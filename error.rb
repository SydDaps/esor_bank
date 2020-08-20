class TransactionError < StandardError
  attr_reader :type
  def initialize(msg="Something happened", type="TransactionError")
    @type = type
    super(msg)
  end
end