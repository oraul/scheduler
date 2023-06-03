# frozen_string_literal: true

class SchedulesController < ApplicationController
  before_action :set_schedule, only: %i[show update destroy]

  # GET /schedules
  def index
    @schedules = Schedule.all

    render json: @schedules
  end

  # GET /schedules/1
  def show
    render json: @schedule
  end

  # POST /schedules
  def create
    @schedule = Schedule.new(schedule_params)

    if @schedule.save
      render json: @schedule, status: :created, location: @schedule
    else
      render json: { message: I18n.t('error.record_invalid'), detail: @schedule.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /schedules/1
  def update
    if @schedule.update(schedule_params)
      render json: @schedule
    else
      render json: { message: I18n.t('error.record_invalid'), detail: @schedule.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /schedules/1
  def destroy
    @schedule.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def schedule_params
    params.require(:schedule).permit(:title, :started_at, :ended_at, :room_id)
  end
end
