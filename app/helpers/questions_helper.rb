module QuestionsHelper
  def check_hashtags(text)
    text.gsub(/(#[[[:word:]]-]+)/) { search_questions($1) }
  end

  def search_questions(hashtag)
    link_to hashtag, search_questions_path(hashtag: hashtag.downcase.delete("#"))
  end
end
