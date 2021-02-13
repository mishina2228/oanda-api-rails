class ResqueSchedulesController < ApplicationController
  before_action :set_resque_schedule, only: [:edit, :update]

  def index
    @resque_schedules = ResqueSchedule.all
  end

  def edit
  end

  def update
    @resque_schedule.attributes = resque_schedule_params
    respond_to do |format|
      @resque_schedule.save_and_setting!
      format.html {redirect_to({action: :index}, notice: t('helpers.notice.update'))}
    rescue ActiveRecord::RecordInvalid, Redis::CannotConnectError
      format.html {render :edit}
    end
  end

  def setup_all
    ResqueSchedule.all.find_each(&:setup_resque_schedule)
    redirect_to({action: :index}, notice: t('helpers.notice.setup_all_resque_schedules'))
  end

  def schedule
    begin
      @actual = JobUtils.schedule
    rescue Redis::CannotConnectError => e
      Rails.logger.warn e.message
      @actual = e.message
    end

    render json: @actual
  end

  private

  def set_resque_schedule
    @resque_schedule = ResqueSchedule.find(params[:id])
  end

  def resque_schedule_params
    params.fetch(:resque_schedule, {}).permit(:enabled)
  end
end
