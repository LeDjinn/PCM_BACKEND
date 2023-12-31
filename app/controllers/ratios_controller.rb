class RatiosController < ApplicationController
  before_action :set_ratio, only: %i[ show edit update destroy ]

  # GET /ratios or /ratios.json
  def index
    @ratios = Ratio.all
  end

  # GET /ratios/1 or /ratios/1.json
  def show
  end

  # GET /ratios/new
  def new
    @ratio = Ratio.new
  end

  # GET /ratios/1/edit
  def edit
  end

  # POST /ratios or /ratios.json
  def create
    @ratio = Ratio.new(ratio_params)

    respond_to do |format|
      if @ratio.save
        format.html { redirect_to ratio_url(@ratio), notice: "Ratio was successfully created." }
        format.json { render :show, status: :created, location: @ratio }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ratio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ratios/1 or /ratios/1.json
  def update
    respond_to do |format|
      if @ratio.update(ratio_params)
        format.html { redirect_to ratio_url(@ratio), notice: "Ratio was successfully updated." }
        format.json { render :show, status: :ok, location: @ratio }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ratio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratios/1 or /ratios/1.json
  def destroy
    @ratio.destroy

    respond_to do |format|
      format.html { redirect_to ratios_url, notice: "Ratio was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ratio
      @ratio = Ratio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ratio_params
      params.require(:ratio).permit(:dn, :tps_demandrinage, :ratio_ac, :ratio_rm)
    end
end
