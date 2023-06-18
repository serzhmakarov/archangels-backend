class Api::V1::PartnersController < ApplicationController
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

  def create
    @partner = Partner.new(partner_params)
    @partner.social_networks = partner_params[:social_networks]
    @partner.photo.attach(partner_params[:photo])

    if @partner.save
      render json: @partner, serializer: PartnerSerializer, status: :created
    else
      render json: @partner.errors, status: :unprocessable_entity
    end
  end

  def update
    @partner = Partner.find(params[:id])
    @partner.social_networks = partner_params[:social_networks]

    if @partner.update(partner_params)
      if partner_params[:photo].present?
        # TODO: Fix photo purge Access Denied
        # @partner.photo.purge
        @partner.photo.attach(partner_params[:photo])
      end
      render json: @partner, serializer: PartnerSerializer, show_projects: true, status: :ok
    else
      render json: @partner.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @partner = Partner.find(params[:id])
    @partner.destroy

    render json: { status: 'success', message: 'Partner was successfully deleted.' }, status: :ok
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

  def partner_params
    params.require(:partner).permit(:name, :short_description, :long_description, :photo, :social_networks)
  end
end
