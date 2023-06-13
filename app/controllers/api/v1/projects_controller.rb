class Api::V1::ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :update]
  before_action :check_admin, only: [:create, :destroy, :update]

  def index
    load_projects
    
    render json: { 
      data: ActiveModel::Serializer::CollectionSerializer.new(@projects, serializer: ProjectSerializer),
      meta: {
          total_pages: @projects.total_pages,
          current_page: @projects.current_page,
          next_page: @projects.next_page,
          prev_page: @projects.prev_page,
          total_count: @projects.total_count
      },
    }, status: :ok
  end

  def show
    @project = Project.find(params[:id])
    render json: @project, serializer: ProjectSerializer, status: :ok
  end

  def create
    @project = Project.new(project_params)
    @project.photo.attach(project_params[:photo])

    if @project.save
      render json: @project, serializer: ProjectSerializer, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    @project = Project.find(params[:id])
  
    if @project.update(project_params)
      if project_params[:photo].present?
        # TODO: Fix photo purge Access Denied
        # @project.photo.purge
        @project.photo.attach(project_params[:photo])
      end
      render json: @project, serializer: ProjectSerializer, status: :ok
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    render json: { status: 'success', message: 'Project was successfully deleted.' }, status: :ok
  end

  private

  def load_projects
    @projects ||= 
      Project
        .order(priority: :desc, date: :desc)
        .page(params[:page])
        .per(params[:per_page])
  end

  def check_admin
    unless current_user.admin?
      flash[:alert] = "You don't have permission to do that."
      redirect_to root_path
    end
  end

  def project_params
    params.require(:project).permit(:name, :short_description, :long_description, :date, :photo, :priority)
  end
end
