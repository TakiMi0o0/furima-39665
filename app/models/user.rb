class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birthday, presence: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: 'は半角英数を両方含む必要があります' }
  validates :last_name, :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/u, message: 'は漢字・ひらがな・カタカナで入力して下さい' }
  validates :last_name_kana, :first_name_kana, presence: true, format: { with: /\A[ァ-ヴー]+\z/u, message: 'はカタカナで入力して下さい' }
end
