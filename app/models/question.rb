class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions

  validates :body, presence: true, length: { maximum: 280 }

  after_save_commit :create_hashtags

  private

  def create_hashtags
    self.hashtags =
      "#{body} #{answer}"
      .downcase
      .scan(Hashtag::REGEXP)
      .uniq
      .map { |hashtag| Hashtag.find_or_create_by(name: hashtag.delete('#')) }
  end
end
