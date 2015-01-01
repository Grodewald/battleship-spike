class ShipPlacementsController < ApplicationController
  before_action :set_ship_placement, only: [:show, :edit, :update, :destroy]

  # GET /ship_placements
  # GET /ship_placements.json
  def index
    @ship_placements = ShipPlacement.all
  end

  # GET /ship_placements/1
  # GET /ship_placements/1.json
  def show
  end

  # GET /ship_placements/new
  def new
    @ship_placement = ShipPlacement.new
  end

  # GET /ship_placements/1/edit
  def edit
  end

  # POST /ship_placements
  # POST /ship_placements.json
  def create
    @ship_placement = ShipPlacement.new(ship_placement_params)

    respond_to do |format|
      if @ship_placement.save
        format.html { redirect_to @ship_placement, notice: 'Ship placement was successfully created.' }
        format.json { render :show, status: :created, location: @ship_placement }
      else
        format.html { render :new }
        format.json { render json: @ship_placement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ship_placements/1
  # PATCH/PUT /ship_placements/1.json
  def update
    respond_to do |format|
      if @ship_placement.update(ship_placement_params)
        format.html { redirect_to @ship_placement, notice: 'Ship placement was successfully updated.' }
        format.json { render :show, status: :ok, location: @ship_placement }
      else
        format.html { render :edit }
        format.json { render json: @ship_placement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ship_placements/1
  # DELETE /ship_placements/1.json
  def destroy
    @ship_placement.destroy
    respond_to do |format|
      format.html { redirect_to ship_placements_url, notice: 'Ship placement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ship_placement
      @ship_placement = ShipPlacement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ship_placement_params
      params.require(:ship_placement).permit(:ship_id, :game_id, :top_left_value, :orientation)
    end
end
