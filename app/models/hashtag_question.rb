class HashtagQuestion < ApplicationRecord
  belongs_to :hashtag
  belongs_to :question, optional: true
end
