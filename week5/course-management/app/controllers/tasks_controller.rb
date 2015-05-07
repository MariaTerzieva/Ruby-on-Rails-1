class TasksController < ApplicationController
  def index
    @tasks = Task.where(lecture_id: params[:lecture_id]).all

  end

  def show
    @task = Task.find_by(id: params[:id])
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to lecture_task_path(@task.solution, @task)
    else
      render :new
    end
  end

  def new
    @task = Task.new
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    @task.destroy
    redirect_to lecture_tasks_path
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.update(task_params)
      redirect_to lecture_task_path(@task.lecture, @task)
    else
      render :edit
    end
  end

  private
    def task_params
      params.require(:task).permit(:name, :description, :lecture_id)
    end
end