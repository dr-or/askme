class User < ApplicationRecord
  has_secure_password

  VALID_EMAIL_REGEXP = /\A[a-z\d_+.\-]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_NAVBAR_COLOR_REGEXP = /\A\#\h{3}{1,2}\z/
  VALID_NICKNAME_REGEXP = /\A\w+\z/

  has_many :questions, dependent: :delete_all
  has_many :authored_questions, class_name: 'Question', foreign_key: 'author_id',
    dependent: :nullify

  before_validation :downcase_email
  before_validation :downcase_nickname

  validates :email, presence: true, uniqueness: true,
    format: { with: VALID_EMAIL_REGEXP }
  validates :navbar_color, format: { with: VALID_NAVBAR_COLOR_REGEXP }
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 40 },
    format: { with: VALID_NICKNAME_REGEXP }

  private

  def downcase_email
    email&.downcase!
  end

  def downcase_nickname
    nickname&.downcase!
  end
end
