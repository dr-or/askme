class QuestionsController < ApplicationController
  before_action :set_question, only: %i[destroy edit hide show update]

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to question_path(@question), notice: 'your question is created'
    else
      flash.now[:alert] = 'data invalid'

      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to question_path(@question), notice: 'your question is updated'
    else
      flash.now[:alert] = 'data invalid'

      render :edit
    end
  end

  def destroy
    @question.destroy

    redirect_to questions_path, notice: 'your question is deleted'
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
    @question = Question.new
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
