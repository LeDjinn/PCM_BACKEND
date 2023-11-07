class TubesController < ApplicationController
  before_action :set_tube, only: %i[ show edit update destroy ]

  # GET /tubes or /tubes.json
  def index
    @tubes = Tube.all
  end

  # GET /tubes/1 or /tubes/1.json
  def show
  end

  # GET /tubes/new
  def new
    @tube = Tube.new
  end

  # GET /tubes/1/edit
  def edit
  end

  # POST /tubes or /tubes.json
  def create
    @tube = Tube.new(tube_params)

    respond_to do |format|
      if @tube.save
        format.html { redirect_to tube_url(@tube), notice: "Tube was successfully created." }
        format.json { render :show, status: :created, location: @tube }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tube.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tubes/1 or /tubes/1.json
  def update
    respond_to do |format|
      if @tube.update(tube_params)
        format.html { redirect_to tube_url(@tube), notice: "Tube was successfully updated." }
        format.json { render :show, status: :ok, location: @tube }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tube.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tubes/1 or /tubes/1.json
  def destroy
    @tube.destroy

    respond_to do |format|
      format.html { redirect_to tubes_url, notice: "Tube was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tube
      @tube = Tube.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tube_params
      params.require(:tube).permit(:country, :pressure, :mat, :type_piece, :dn, :ac, :rm, :quantity, :price_mo, :voile_ac, :barear_ac, :charge_ac, :resine_rm, :charge_rm, :color, :number_voile_ac, :quotation_id)
    end
end
