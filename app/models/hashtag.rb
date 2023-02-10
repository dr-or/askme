class Hashtag < ApplicationRecord
  REGEXP = /#[[[:word:]]-]+/

  scope :question_hashtags_only, -> { joins(:hashtag_questions).distinct }

  has_many :hashtag_questions
  has_many :questions, through: :hashtag_questions

  validates :name, uniqueness: true
end
