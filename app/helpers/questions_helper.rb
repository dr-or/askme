module QuestionsHelper
  def link_hashtags(text)
    text.gsub(Hashtag::REGEXP) do |hashtag|
      link_to hashtag, search_questions_path(hashtag: hashtag.downcase.delete("#"))
    end
  end
end
