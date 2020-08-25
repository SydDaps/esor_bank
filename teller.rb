require_relative "user"
require_relative "database"
require_relative "query"


class Teller < User
  include Query
  extend Query

  attr_reader :id
  @@teller_id = 1001
  def initialize(fields)
    super
    @id =  @@teller_id
    @@teller_id += 1
  end

end



