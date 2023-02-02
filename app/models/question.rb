class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions

  validates :body, presence: true, length: { maximum: 280 }

  after_commit :find_hashtags, on: [:create, :update]

  private

  def find_hashtags
    entire_text.scan(/#[[[:word:]]-]+/).uniq.each { |hashtag| create_or_find(hashtag) }
  end

  def create_or_find(hashtag)
    the_hashtag = Hashtag.find_or_create_by(name: hashtag.downcase.delete('#'))
    create_reference(the_hashtag)
  end

  def create_reference(hashtag)
    question = Question.find_by(id: self.id)
    HashtagQuestion.find_or_create_by(hashtag: hashtag, question: question)
  end

  def entire_text
    return body + answer unless answer.nil?
    body
  end
end
