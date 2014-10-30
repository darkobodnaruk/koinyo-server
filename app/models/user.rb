class User < ActiveRecord::Base
  has_many :addresses

  def generate_confirmation_code
    (0..5).map{rand(10)}.join
  end

  def create

  end
end
