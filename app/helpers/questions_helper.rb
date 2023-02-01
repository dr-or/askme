module QuestionsHelper
  def check_hashtags(text)
    text.gsub(/(#[\w-]+)/) { search_questions($1) }
  end

  def search_questions(hashtag)
    link_to hashtag, search_questions_path(hashtag: hashtag.delete("#"))
  end
end
