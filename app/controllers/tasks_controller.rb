class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy, :assign, :assign_update]

  def index
    @tasks = Task.all
  end

  def show
  end

  def mytask
    @tasks = Task.where(user_id: current_user.id)
  end

  def assign
    @users = User.all
  end

  def assign_update
    if @task.update(user_id: user_params[:user].to_i)
      redirect_to @task, notice: 'タスクのアサインを更新しました'
    else
      render :edit
    end
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id

      if @task.save
        redirect_to @task, notice: 'タスクを作成しました'
      else
        render :new
      end
  end

  def update
         @task = Task.find(params[:id])
      if @task.update(task_params)
        redirect_to @task, notice: 'タスクを更新しました'
      else
        render :edit
      end
  end

  def destroy
    if @task.user_id == current_user.id
       @task.destroy
       redirect_to tasks_url, notice: 'タスクを削除しました'
    else
       redirect_to tasks_url, notice: '担当者だけが削除出来ます'
    end
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :content, :deadline, :status, :user_id)
    end

    def user_params
      params.require(:task).permit(:user)
    end
end
