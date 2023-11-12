class FightsController < ApplicationController
  before_action :set_fight, only: %i[ show destroy execute]

  def index
    @fights = Fight.all.order(id: :desc)
  end

  def new
    @fight_form = FightForm.new
  end

  def create
    @fight_form = FightForm.new(**fight_params.to_h.symbolize_keys)

    if @fight_form.save
      redirect_to fight_url(@fight_form.fight), notice: "The fight was successfully created."
    else
      render :new
    end
  end

  def show; end

  def execute
    execute_service = Fights::Execute.new(fight: @fight)

    if execute_service.call
      redirect_to fight_url(@fight), notice: "The fight was successfully executed."
    else
      redirect_to fight_url(@fight), alert: "Errors, #{execute_service.error_message}"
    end
  end

  def destroy; end

  private

  def set_fight
    @fight = Fight.find(params[:id])
  end

  def fight_params
    params.require(:fight_form).permit(:first_gladiator_id, :second_gladiator_id)
  end
end