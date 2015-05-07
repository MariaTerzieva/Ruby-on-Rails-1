class LecturesController < ApplicationController
  def index
    @lectures = Lecture.all
  end

  def show
    @lecture = Lecture.find_by(id: params[:id])
  end

  def new
    @lecture = Lecture.new
  end

  def create
    @lecture = Lecture.new(lecture_params)

    if @lecture.save
      redirect_to @lecture
    else
      render :new
    end
  end

  def destroy
    @lecture = Lecture.find_by(id: params[:id])
    @lecture.destroy
    redirect_to lectures_url
  end

  def edit
    @lecture = Lecture.find_by(id: params[:id])
  end

  def update
    @lecture = Lecture.find_by(id: params[:id])
    if @lecture.update(lecture_params)
      redirect_to @lecture
    else
      render :edit
    end
  end

  private
    def lecture_params
      params.require(:lecture).permit(:name, :text_body)
    end
end