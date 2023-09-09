class Api::V1::ProjectsController < ApiController
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
    params.require(:project).permit(:name, :short_description, :long_description, :date, :photo, :priority, :social_networks)
  end
end
