class GladiatorsController < ApplicationController
  before_action :set_gladiator, only: %i[ show edit update destroy ]

  # In ancient Rome, the ludus is where gladiators live,
  # train and prepare for the path of glory
  def the_ludus; end

  def index
    @gladiators = Gladiator.all
  end

  def show
  end

  def new
    @gladiator = Gladiator.new
  end

  def edit
  end

  def create
    @gladiator = Gladiator.new(gladiator_params)

    if @gladiator.save
      redirect_to gladiator_url(@gladiator), notice: "Gladiator was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @gladiator.update(gladiator_params)
      redirect_to gladiator_url(@gladiator), notice: "Gladiator was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gladiator.destroy

    redirect_to gladiators_url, notice: "Gladiator was successfully destroyed."
  end

  private
    def set_gladiator
      @gladiator = Gladiator.find(params[:id])
    end

    def gladiator_params
      params.require(:gladiator).permit(:name, :life_points, :attack_points, :magic_points, :health_status, :age, :avatar)
    end
end
