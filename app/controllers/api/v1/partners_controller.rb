class Api::V1::PartnersController < ApiController
  before_action :authenticate_user!, only: [:create, :destroy, :update]
  before_action :check_admin, only: [:create, :destroy, :update]

  def index
    load_partners

    render json: { 
      data: ActiveModel::Serializer::CollectionSerializer.new(@partners, serializer: PartnerSerializer, show_projects: true),
      meta: {
          total_pages: @partners.total_pages,
          current_page: @partners.current_page,
          next_page: @partners.next_page,
          prev_page: @partners.prev_page,
          total_count: @partners.total_count
      },
    }, status: :ok
  end

  def show
    @partner = Partner.find(params[:id])
    render json: @partner, serializer: PartnerSerializer, show_projects: true, status: :ok
  end

  private

  def load_partners
    @partners ||= 
      Partner
        .page(params[:page])
        .per(params[:per_page])
        .order(created_at: :desc)
  end

  def check_admin
    unless current_user.admin?
      flash[:alert] = "You don't have permission to do that."
      redirect_to root_path
    end
  end
end
