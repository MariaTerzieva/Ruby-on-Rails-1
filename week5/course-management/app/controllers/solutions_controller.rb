class SolutionsController < ApplicationController
  def index
    @solutions = Solution.where(task_id: params[:task_id]).all
  end

  def show
    @solution = Solution.find_by(id: params[:id])
  end

  def create
    @solution = Solution.new(solution_params)

    if @solution.save
      redirect_to lecture_task_solution_path(@solution.task.lecture, @solution.task, @solution)
    else
      render :new
    end
  end

  def new
    @solution = Solution.new(params.permit(:code, :task_id))
  end

  def destroy
    @solution = Solution.find_by(id: params[:id])
    @solution.destroy
    redirect_to lecture_task_solutions_path
  end

  def edit
    @solution = Solution.find_by(id: params[:id])
  end

  def update
    @solution = Solution.find_by(id: params[:id])
    if @solution.update(solution_params)
      redirect_to lecture_task_solution_path(@solution.task.lecture, @solution.task, @solution)
    else
      render :edit
    end
  end

  private
    def solution_params
      params.require(:solution).permit(:code, :task_id)
    end
end