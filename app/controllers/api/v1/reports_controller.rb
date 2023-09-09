class Api::V1::ReportsController < ApiController
  before_action :authenticate_user!, only: [:create, :destroy, :update]
  before_action :check_admin, only: [:create, :destroy, :update]

  def index
    load_reports

    render json: { 
      data: ActiveModel::Serializer::CollectionSerializer.new(@reports, serializer: ReportSerializer),
      meta: {
          total_pages: @reports.total_pages,
          current_page: @reports.current_page,
          next_page: @reports.next_page,
          prev_page: @reports.prev_page,
          total_count: @reports.total_count
      },
    }, status: :ok
  end

  def show
    @report = Report.find(params[:id])
    render json: @report, serializer: ReportSerializer, status: :ok
  end

  def create
    @report = Report.new(report_params)
    @report.photo.attach(report_params[:photo])

    if @report.save
      render json: @report, serializer: ReportSerializer, status: :created
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  def update
    @report = Report.find(params[:id])
  
    if @report.update(report_params)
      if report_params[:photo].present?
        @report.photo.purge
        @report.photo.attach(report_params[:photo])
      end
      render json: @report, serializer: ReportSerializer, status: :ok
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    render json: { status: 'success', message: 'Report was successfully deleted.' }, status: :ok
  end

  private

  def load_reports
    @reports ||=
      Report
        .order(created_at: :desc)
        .page(params[:page])
        .per(params[:per_page])
  end

  def check_admin
    unless current_user.admin?
      flash[:alert] = "You don't have permission to do that."
      redirect_to root_path
    end
  end

  def report_params
    params.require(:report).permit(:name, :short_description, :long_description, :date, :photo)
  end
end
