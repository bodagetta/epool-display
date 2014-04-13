class PointsController < ApplicationController
  before_action :set_point, only: [:show, :edit, :update, :destroy]

  # GET /points
  # GET /points.json
  def index
    @points = Point.all

    data_table = GoogleVisualr::DataTable.new
    # Add Column Headers
    data_table.new_column('number', 'DateTime' )
    data_table.new_column('number', 'Temperature (raw)')
    #data_table.add_rows([
    #['2004', 1000],
    #['2005', 1170],
    #['2006', 660],
    #['2007', 1030]
    #])
    dataArray = Array.new
    Point.all.each do |point|
      elementArray = Array.new
      elementArray.push(point.id)
      elementArray.push(point.temperature)
      dataArray.push(elementArray)
    end

    data_table.add_rows(dataArray)

    option = { width: 600, height: 400, title: 'Raw Temperature Data' }
    @chart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)

  end

  # GET /points/1
  # GET /points/1.json
  def show
  end

  # GET /points/new
  def new
    @point = Point.new
  end

  # GET /points/1/edit
  def edit
  end

  # POST /points
  # POST /points.json
  def create
    @point = Point.new(point_params)

    respond_to do |format|
      if @point.save
        format.html { redirect_to @point, notice: 'Point was successfully created.' }
        format.json { render action: 'show', status: :created, location: @point }
      else
        format.html { render action: 'new' }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /points/1
  # PATCH/PUT /points/1.json
  def update
    respond_to do |format|
      if @point.update(point_params)
        format.html { redirect_to @point, notice: 'Point was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /points/1
  # DELETE /points/1.json
  def destroy
    @point.destroy
    respond_to do |format|
      format.html { redirect_to points_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_point
      @point = Point.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def point_params
      params.require(:point).permit(:shortAddr, :extAddr, :nodeType, :temperature, :softVersion, :battery, :light, :messageType, :workingChannel, :sensorsSize, :lqi, :rssi, :parentShortAddr, :panID, :channelMask) if params[:point]
    end
end