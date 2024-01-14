class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, foreign_key: :customer_id, dependent: :destroy
  has_many :orders, dependent: :destroy

    def full_name
    "#{first_name} #{last_name}"
    end

    def full_name_kana
    "#{first_name_kana} #{last_name_kana}"
    end

    def addresses
      '〒' + postal_code + ' ' + address + ' ' + full_name
    end

end
