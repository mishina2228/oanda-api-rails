class ResqueSchedulesController < ApplicationController
  before_action :set_resque_schedule, only: [:show, :edit, :update]

  def index
    @resque_schedules = ResqueSchedule.all
    begin
      @actual = JobUtils.schedule
    rescue Redis::CannotConnectError => e
      Rails.logger.warn e.message
      @actual = e.message
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @resque_schedule.update(resque_schedule_params)
        @resque_schedule.setup_resque_schedule
        format.html {redirect_to @resque_schedule, notice: 'Resque schedule was successfully updated.'}
      else
        format.html {render :edit}
      end
    end
  end

  def setup_all
    ResqueSchedule.all.find_each(&:setup_resque_schedule)
    redirect_to action: :index, notice: 'Resque schedules were all set.'
  end

  private

  def set_resque_schedule
    @resque_schedule = ResqueSchedule.find(params[:id])
  end

  def resque_schedule_params
    params.fetch(:resque_schedule, {}).permit(:enabled)
  end
end
