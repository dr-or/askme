class QuestionsController < ApplicationController
  before_action :set_question, only: %i[destroy edit hide show update]

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to user_path(@question.user), notice: 'your question is created'
    else
      flash.now[:alert] = 'data invalid'

      render :new
    end
  end

  def update
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

  def show
  end

  def index
    @question = Question.new

    @questions = Question.all
  end

  def new
    @user = User.find(params[:user_id])
    @question = Question.new(user: @user)
  end

  def edit
  end

  private

  def question_params
    params.require(:question).permit(:body, :user_id)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
