class Api::V1::ReportsController < ApplicationController
  def index
    @reports = Report.order(created_at: :desc)
    render json: @reports, each_serializer: ReportSerializer, status: :ok
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

  def report_params
    params.require(:report).permit(:name, :short_description, :long_description, :date, :photo)
  end
end
