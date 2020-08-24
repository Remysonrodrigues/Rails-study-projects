class ItemsController < ApplicationController
  before_action :set_task
  before_action :set_task_item, only: [:show, :update, :destroy]

  # GET /tasks/:task_id/items
  def index
    json_response(@task.items)
  end

  # GET /tasks/:task_id/items/:id
  def show
    json_response(@item)
  end

  # POST /tasks/:task_id/items
  def create
    @task.items.create!(item_params)
    json_response(@task, :created)
  end

  # PUT /tasks/:task_id/items/:id
  def update
    @item.update(item_params)
    head :no_content
  end

  # DELETE /tasks/:task_id/items/:id
  def destroy
    @item.destroy
    head :no_content
  end

  private

    def item_params
      params.permit(:name, :done)
    end

    def set_task
      @task = Task.find(params[:task_id])
    end

    def set_task_item
      @item = @task.items.find_by!(id: params[:id]) if @task
    end
    
end
