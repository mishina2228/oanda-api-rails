class ResqueSchedulesController < ApplicationController
  before_action :set_resque_schedule, only: [:show, :edit, :update]

  def index
    @resque_schedules = ResqueSchedule.all
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

  private

  def set_resque_schedule
    @resque_schedule = ResqueSchedule.find(params[:id])
  end

  def resque_schedule_params
    params.fetch(:resque_schedule, {}).permit(:enabled)
  end
end
