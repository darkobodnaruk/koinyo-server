class User < ActiveRecord::Base
  has_many :addresses

  before_create :generate_access_token
  before_create :generate_confirmation_code

  private
    def generate_access_token
      self.access_token = SecureRandom.hex(16)
    end

    def generate_confirmation_code
      self.confirmation_code = (0..5).map{rand(10)}.join
    end
end
