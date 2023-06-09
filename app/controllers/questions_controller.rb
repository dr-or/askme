class QuestionsController < ApplicationController
  before_action :ensure_current_user, only: %i[destroy edit hide update]
  before_action :set_question_for_current_user, only: %i[destroy edit hide update]

  def create
    question_params = params.require(:question).permit(:body, :user_id)

    @question = Question.new(question_params)

    @question.author = current_user

    if @question.save
      redirect_to user_path(@question.user), notice: 'your question is created'
    else
      flash.now[:alert] = 'data invalid'

      render :new
    end
  end

  def update
    question_params = params.require(:question).permit(:body, :answer)

    if @question.update(question_params)
      redirect_to user_path(@question.user), notice: 'your question is updated'
    else
      flash.now[:alert] = 'data invalid'

      render :edit
    end
  end

  def destroy
    @user = @question.user
    @question.destroy

    redirect_to user_path(@user), notice: 'your question is deleted'
  end

  def hide
    @question.toggle!(:hidden)

    redirect_to questions_path
  end

  def search
    @hashtag = Hashtag.question_hashtags_only.find_by!(name: params[:hashtag])
    @questions = @hashtag.questions.includes(%i[user author])
  end

  def show
    @question = Question.find(params[:id])
  end

  def index
    @questions = Question.includes(%i[user author]).order(created_at: :desc).first(10)
    @users = User.order(created_at: :desc).first(10)
    @hashtags = Hashtag.question_hashtags_only
  end

  def new
    @user = User.find_by!(nickname: params[:nickname])
    @question = Question.new(user: @user)
  end

  def edit; end

  private

  def ensure_current_user
    redirect_with_alert unless current_user.present?
  end

  def set_question_for_current_user
    @question = current_user.questions.find(params[:id])
  end
end
