class User < ApplicationRecord
  has_secure_password

  before_validation :downcase_email
  before_validation :downcase_nickname

  validates :email, presence: true, uniqueness: true,
    format: { with: /\A[a-z\d_+.\-]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 40 },
    format: { with: /\A\w+\z/ }

  private

  def downcase_email
    email&.downcase!
  end

  def downcase_nickname
    nickname&.downcase!
  end
end
