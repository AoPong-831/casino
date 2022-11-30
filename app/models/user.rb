class User < ApplicationRecord
    attr_accessor :password, :password_confirmation
    validates :name, presence: true, uniqueness: true
    validates :password, presence: true, confirmation: true
    def password=(val)
        if val.present?
            self.pass = BCrypt::Password.create(val)
        end
        @password = val
    end
end
