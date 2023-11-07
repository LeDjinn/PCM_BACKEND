class LossesController < ApplicationController
  before_action :set_loss, only: %i[ show edit update destroy ]

  # GET /losses or /losses.json
  def index
    @losses = Loss.all
  end

  # GET /losses/1 or /losses/1.json
  def show
  end

  # GET /losses/new
  def new
    @loss = Loss.new
  end

  # GET /losses/1/edit
  def edit
  end

  # POST /losses or /losses.json
  def create
    @loss = Loss.new(loss_params)

    respond_to do |format|
      if @loss.save
        format.html { redirect_to loss_url(@loss), notice: "Loss was successfully created." }
        format.json { render :show, status: :created, location: @loss }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @loss.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /losses/1 or /losses/1.json
  def update
    respond_to do |format|
      if @loss.update(loss_params)
        format.html { redirect_to loss_url(@loss), notice: "Loss was successfully updated." }
        format.json { render :show, status: :ok, location: @loss }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @loss.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /losses/1 or /losses/1.json
  def destroy
    @loss.destroy

    respond_to do |format|
      format.html { redirect_to losses_url, notice: "Loss was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loss
      @loss = Loss.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def loss_params
      params.require(:loss).permit(:dn, :lenght_useful, :loss_orhto, :loss_helico)
    end
end
