module V1
  class TasksController < ApplicationController
    before_action :set_task, only: [:show, :update, :destroy]

    # GET /tasks
    def index
      # obter usuário atual tasks
      @todos = current_user.tasks
      json_response(@todos)
    end

    # POST /tasks
    def create
      # criar tasks pertencentes ao usuário atual
      @task = current_user.tasks.create!(task_params)
      json_response(@task, :created)
    end

    # GET /tasks/:id
    def show
      json_response(@task)
    end

    # PUT /tasks/:id
    def update
      @task.update(task_params)
      head :no_content
    end

    # DELETE /tasks/:id
    def destroy
      @task.destroy
      head :no_content
    end

    private

      # remover `created_by` da lista de parâmetros permitidos
      def task_params
        params.permit(:title)
      end

      def task_params
        # parâmetros da lista
        params.permit(:title, :created_by)
      end

      def set_task
        @task = Task.find(params[:id])
      end

  end
end