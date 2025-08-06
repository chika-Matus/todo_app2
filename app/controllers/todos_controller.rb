# app/controllers/todos_controller.rb
class TodosController < ApplicationController
  before_action :require_user
  before_action :set_todo, only: [:show, :edit, :update, :destroy]
  
  def index
    @todos = current_user.todos.all
  end
  
  def show
  end
  
  def new
    @todo = current_user.todos.build
  end
  
  def create
    @todo = current_user.todos.build(todo_params)
    if @todo.save
      flash[:notice] = "TODOが作成されました"
      redirect_to todos_path
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @todo.update(todo_params)
      flash[:notice] = "TODOが更新されました"
      redirect_to todo_path(@todo)
    else
      render 'edit'
    end
  end
  
  def destroy
    @todo.destroy
    flash[:notice] = "TODOが削除されました"
    redirect_to todos_path
  end
  
  private
  
  def set_todo
    @todo = current_user.todos.find(params[:id])
  end
  
  def todo_params
    params.require(:todo).permit(:title, :description, :completed)
  end
end