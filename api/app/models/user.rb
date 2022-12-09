class User < ApplicationRecord
  has_one :user_company, dependent: :destroy
  has_one :company, through: :user_company

  validates :email, uniqueness: { message: 'はすでに登録済みです' }
  validates :user_company, presence: { message: 'の登録が必要です' }
  validates :first_name, presence: { message: 'は必須項目です' }
  validates :last_name, presence: { message: 'は必須項目です' }

  def display_name
    last_name + first_name
  end
end
