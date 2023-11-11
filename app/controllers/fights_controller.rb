class FightsController < ApplicationController
  before_action :set_fight, only: %i[ show destroy ]

  def index; end

  def new
    @fight_form = FightForm.new
  end

  def create
    @fight_form = FightForm.new(**fight_params.to_h.symbolize_keys)

    if @fight_form.save
      redirect_to fight_url(@fight_form.fight), notice: "The fight was successfully started."
    else
      render :new
    end
  end

  def show; end

  def destroy; end

  private

  def set_fight
    @fight = Fight.find(params[:id])
  end

  def fight_params
    params.require(:fight_form).permit(:first_gladiator_id, :second_gladiator_id)
  end
end