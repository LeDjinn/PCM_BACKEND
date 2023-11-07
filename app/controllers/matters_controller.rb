class MattersController < ApplicationController
  before_action :set_matter, only: %i[ show edit update destroy ]
  require 'csv'
  # GET /matters or /matters.json
  def index
    @matters = Matter.all
  end

  def import
    file = params[:file]
    if file
      return redirect_to matters_path, notice: "Only Csv files " unless file.content_type =='text/csv'
      file=File.open(file)
      csv=CSV.parse(file, headers: true)
    
      csv.each do |row|
        matter_hash={}
        matter_hash[:name]=row["nom"] unless matter_hash[:name]
        matter_hash[:price_local]=row["prix local"] unless  matter_hash[:price_local]
        matter_hash[:price_export]=row["prix export"] unless matter_hash[:price_export]
        matter_hash[:category_id]=row["id de la catégorie"] unless matter_hash[:category_id]
    
        Matter.create(matter_hash)
      end
      return redirect_to matters_path , notice: 'Csv chargé '
    end
  end

  # GET /matters/1 or /matters/1.json
  def show
  end

  # GET /matters/new
  def new
    @matter = Matter.new
  end

  # GET /matters/1/edit
  def edit
  end

  # POST /matters or /matters.json
  def create
    @matter = Matter.new(matter_params)

    respond_to do |format|
      if @matter.save
        format.html { redirect_to matter_url(@matter), notice: "Matter was successfully created." }
        format.json { render :show, status: :created, location: @matter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @matter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matters/1 or /matters/1.json
  def update
    respond_to do |format|
      if @matter.update(matter_params)
        format.html { redirect_to matter_url(@matter), notice: "Matter was successfully updated." }
        format.json { render :show, status: :ok, location: @matter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @matter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matters/1 or /matters/1.json
  def destroy
    @matter.destroy

    respond_to do |format|
      format.html { redirect_to matters_url, notice: "Matter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_matter
      @matter = Matter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def matter_params
      params.require(:matter).permit(:name, :price_local, :price_export, :category_id)
    end
end
