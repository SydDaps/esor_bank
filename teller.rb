require_relative "user"
require_relative "database"
require_relative "query"


class Teller < User
  include Query
  extend Query

  attr_reader :id
  
  def initialize(fields)
    super
  end

end




