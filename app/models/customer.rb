class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    def full_name
    "#{first_name} #{last_name}"
    end

    def full_name_kana
    "#{first_name_kana} #{last_name_kana}"
    end

end
